From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Wed, 23 Aug 2023 11:00:06 +0800
Subject: [PATCH] crypto: Explicitly include correct DT includes
In-Reply-To: <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
References: <20230714174421.4054194-1-robh@kernel.org>
 <CAL_JsqL_CvroupJEFwrjt8WOq=4WBxvE3sOTMnY8hEuBAMG=1g@mail.gmail.com>
Message-ID: <ZOV2Nn4o8Ldy9P1i@gondor.apana.org.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Aug 22, 2023 at 05:40:57PM -0500, Rob Herring wrote:
> On Fri, Jul 14, 2023 at 12:44?PM Rob Herring <robh@kernel.org> wrote:
> >
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those include
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c   | 1 -
> >  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c   | 1 -
> >  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c   | 1 -
> >  drivers/crypto/amlogic/amlogic-gxl-core.c           | 1 -
> >  drivers/crypto/aspeed/aspeed-acry.c                 | 3 ---
> >  drivers/crypto/atmel-aes.c                          | 6 ++----
> >  drivers/crypto/atmel-ecc.c                          | 2 +-
> >  drivers/crypto/atmel-sha.c                          | 6 ++----
> >  drivers/crypto/atmel-tdes.c                         | 6 ++----
> >  drivers/crypto/bcm/cipher.c                         | 3 +--
> >  drivers/crypto/caam/ctrl.c                          | 1 +
> >  drivers/crypto/caam/jr.c                            | 1 +
> >  drivers/crypto/caam/qi.c                            | 1 +
> >  drivers/crypto/ccree/cc_driver.c                    | 1 -
> >  drivers/crypto/exynos-rng.c                         | 2 +-
> >  drivers/crypto/gemini/sl3516-ce-core.c              | 1 -
> >  drivers/crypto/img-hash.c                           | 4 ++--
> >  drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c | 3 ++-
> >  drivers/crypto/n2_core.c                            | 2 +-
> >  drivers/crypto/omap-aes.c                           | 1 -
> >  drivers/crypto/omap-des.c                           | 2 --
> >  drivers/crypto/omap-sham.c                          | 1 -
> >  drivers/crypto/rockchip/rk3288_crypto.c             | 1 -
> >  drivers/crypto/s5p-sss.c                            | 1 -
> >  drivers/crypto/sa2ul.c                              | 3 ++-
> >  drivers/crypto/sahara.c                             | 1 -
> >  drivers/crypto/starfive/jh7110-cryp.c               | 2 +-
> >  drivers/crypto/starfive/jh7110-hash.c               | 1 -
> >  drivers/crypto/stm32/stm32-cryp.c                   | 2 +-
> >  drivers/crypto/stm32/stm32-hash.c                   | 2 +-
> >  drivers/crypto/talitos.c                            | 4 ++--
> >  drivers/crypto/xilinx/zynqmp-aes-gcm.c              | 2 +-
> >  drivers/crypto/xilinx/zynqmp-sha.c                  | 1 -
> >  33 files changed, 25 insertions(+), 45 deletions(-)
> 
> Ping!

Sorry, I misfiled this one.  I'll get onto it now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
