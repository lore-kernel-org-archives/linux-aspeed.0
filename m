From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 5 Oct 2024 13:27:56 +0800
Subject: [PATCH v2 00/19] Migrate to sig_alg and templatize ecdsa
In-Reply-To: <cover.1725972333.git.lukas@wunner.de>
References: <cover.1725972333.git.lukas@wunner.de>
Message-ID: <ZwDOXKZ8QrOvpGAW@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 10, 2024 at 04:30:10PM +0200, Lukas Wunner wrote:
> The original impetus of this series is to introduce P1363 signature
> decoding for ecdsa (patch [18/19]), which is needed by the upcoming
> SPDM library (Security Protocol and Data Model) for PCI device
> authentication.
> 
> To facilitate that, move X9.62 signature decoding out of ecdsa.c and
> into a template (patch [15/19]).
> 
> New in v2:  Move the maximum signature size calculations for ecdsa
> out of software_key_query() and into the X9.62 template so that
> corresponding calculations can be added for P1363 without further
> cluttering up software_key_query() (patch [16/19] - [17/19]).
> 
> New in v2:  Avoid inefficient copying from kernel buffers to sglists
> in the new templates by introducing a sig_alg backend and migrating
> all algorithms to it, per Herbert's advice (patch [02/19] - [12/19]).
> 
> Clean up various smaller issues that caught my eye in ecdsa
> (patch [01/19] and [14/19]), ecrdsa (patch [19/19]) and
> ASN.1 headers (patch [13/19]).
> 
> I've also accumulated various cleanups for crypto virtio on my
> development branch but will leave them for another day as this
> series is already nearing the "too big to review" threshold. ;)
> 
> I've run selftests on every single commit, but further testing
> would be appreciated to raise the confidence.
> 
> 
> Link to v1:
> 
> https://lore.kernel.org/all/cover.1722260176.git.lukas at wunner.de/
> 
> Changes v1 -> v2:
> 
> * [PATCH 13/19] ASN.1: Clean up include statements in public headers
>   * Drop "#include <linux/bug.h>" from <linux/asn1_encoder.h> (Jonathan)
> 
> * [PATCH 14/19] crypto: ecdsa - Avoid signed integer overflow on signature
>   decoding
>   * Add code comment explaining why vlen may be larger than bufsize (Stefan)
> 
> * [PATCH 15/19] crypto: ecdsa - Move X9.62 signature decoding into template
>   * Drop unnecessary "params", "param_len" and "algo" definitions from
>     ecdsa_nist_p{192,256,384,521}_tv_template[].
>   * Introduce and use struct ecdsa_raw_sig in <crypto/internal/ecc.h>.
> 
> * [PATCH 18/19] crypto: ecdsa - Support P1363 signature decoding
>   * Drop unnecessary "params", "param_len" and "algo" definitions from
>     p1363_ecdsa_nist_p256_tv_template[].
> 
> 
> Lukas Wunner (19):
>   crypto: ecdsa - Drop unused test vector elements
>   crypto: sig - Introduce sig_alg backend
>   crypto: ecdsa - Migrate to sig_alg backend
>   crypto: ecrdsa - Migrate to sig_alg backend
>   crypto: rsa-pkcs1pad - Deduplicate set_{pub,priv}_key callbacks
>   crypto: rsassa-pkcs1 - Migrate to sig_alg backend
>   crypto: rsassa-pkcs1 - Harden digest length verification
>   crypto: rsassa-pkcs1 - Avoid copying hash prefix
>   crypto: virtio - Drop sign/verify operations
>   crypto: drivers - Drop sign/verify operations
>   crypto: akcipher - Drop sign/verify operations
>   crypto: sig - Move crypto_sig_*() API calls to include file
>   ASN.1: Clean up include statements in public headers
>   crypto: ecdsa - Avoid signed integer overflow on signature decoding
>   crypto: ecdsa - Move X9.62 signature decoding into template
>   crypto: sig - Rename crypto_sig_maxsize() to crypto_sig_keysize()
>   crypto: ecdsa - Move X9.62 signature size calculation into template
>   crypto: ecdsa - Support P1363 signature decoding
>   crypto: ecrdsa - Fix signature size calculation
> 
>  Documentation/crypto/api-akcipher.rst         |   2 +-
>  Documentation/crypto/api-sig.rst              |  15 +
>  Documentation/crypto/api.rst                  |   1 +
>  Documentation/crypto/architecture.rst         |   2 +
>  crypto/Kconfig                                |   5 +-
>  crypto/Makefile                               |   5 +-
>  crypto/akcipher.c                             |  64 +-
>  crypto/asymmetric_keys/public_key.c           |  58 +-
>  crypto/ecdsa-p1363.c                          | 159 ++++
>  crypto/ecdsa-x962.c                           | 237 +++++
>  crypto/ecdsa.c                                | 209 ++---
>  crypto/ecrdsa.c                               |  64 +-
>  crypto/internal.h                             |  19 -
>  crypto/rsa-pkcs1pad.c                         | 371 +-------
>  crypto/rsa.c                                  |  17 +-
>  crypto/rsassa-pkcs1.c                         | 442 +++++++++
>  crypto/sig.c                                  | 143 +--
>  crypto/testmgr.c                              | 320 +++++--
>  crypto/testmgr.h                              | 884 +++++++++++++++---
>  drivers/crypto/aspeed/aspeed-acry.c           |   2 -
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c   |   2 -
>  drivers/crypto/starfive/jh7110-rsa.c          |   2 -
>  .../virtio/virtio_crypto_akcipher_algs.c      |  65 +-
>  include/crypto/akcipher.h                     |  69 +-
>  include/crypto/internal/akcipher.h            |   4 +-
>  include/crypto/internal/ecc.h                 |  14 +
>  include/crypto/internal/rsa.h                 |  29 +
>  include/crypto/internal/sig.h                 |  80 ++
>  include/crypto/sig.h                          | 152 ++-
>  include/linux/asn1_decoder.h                  |   1 +
>  include/linux/asn1_encoder.h                  |   1 -
>  include/linux/slab.h                          |   1 +
>  include/uapi/linux/cryptouser.h               |   5 +
>  include/uapi/linux/virtio_crypto.h            |   1 +
>  security/integrity/ima/ima_main.c             |   6 +-
>  35 files changed, 2398 insertions(+), 1053 deletions(-)
>  create mode 100644 Documentation/crypto/api-sig.rst
>  create mode 100644 crypto/ecdsa-p1363.c
>  create mode 100644 crypto/ecdsa-x962.c
>  create mode 100644 crypto/rsassa-pkcs1.c
> 
> -- 
> 2.43.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
