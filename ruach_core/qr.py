"""Optional QR rendering for congregation links; core runtime does not require qrcode."""

from io import BytesIO
from urllib.parse import urlsplit, urlunsplit

def congregation_url(base_url, token):
    if not isinstance(base_url, str) or len(base_url) > 500:
        raise ValueError("invalid public base URL")
    parts = urlsplit(base_url.strip())
    if parts.scheme not in ("http", "https") or not parts.netloc or parts.username or parts.password or parts.query or parts.fragment:
        raise ValueError("invalid public base URL")
    clean_path = parts.path.rstrip("/")
    return urlunsplit((parts.scheme, parts.netloc, clean_path + "/c/" + token, "", ""))

def render_qr_svg(url):
    try:
        import qrcode
        from qrcode.image.svg import SvgPathImage
    except ImportError as exc:
        raise RuntimeError("QR support requires the optional qrcode extra") from exc
    qr = qrcode.QRCode(version=None, error_correction=qrcode.constants.ERROR_CORRECT_M, box_size=8, border=4)
    qr.add_data(url)
    qr.make(fit=True)
    out = BytesIO()
    qr.make_image(image_factory=SvgPathImage).save(out)
    return out.getvalue().decode("utf-8")
