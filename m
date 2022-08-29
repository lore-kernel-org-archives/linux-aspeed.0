From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 29 Aug 2022 11:47:08 +0100
Subject: build failure of next-20220829 due to 108713a713c7 ("crypto:
 aspeed - Add HACE hash driver")
In-Reply-To: <TY2PR06MB321356F6EB09D3D59D37B53F80769@TY2PR06MB3213.apcprd06.prod.outlook.com>
References: <YwyORp72cuDrVYdA@debian> <TY2PR06MB321356F6EB09D3D59D37B53F80769@TY2PR06MB3213.apcprd06.prod.outlook.com>
Message-ID: <CADVatmMevKbZ+gHfG-7kuy3s=K2_Qe1OOVrL92OUiTMeoK7ViA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 29, 2022 at 11:04 AM Neal Liu <neal_liu@aspeedtech.com> wrote:
>
> > -----Original Message-----
> > From: Sudip Mukherjee (Codethink) <sudipm.mukherjee@gmail.com>
> > Sent: Monday, August 29, 2022 6:01 PM
> > To: Neal Liu <neal_liu@aspeedtech.com>; Johnny Huang
> > <johnny_huang@aspeedtech.com>; Dhananjay Phadke
> > <dphadke@linux.microsoft.com>; Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: David S. Miller <davem@davemloft.net>; Joel Stanley <joel@jms.id.au>;
> > Andrew Jeffery <andrew@aj.id.au>; linux-aspeed at lists.ozlabs.org;
> > linux-crypto at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > linux-kernel at vger.kernel.org; linux-next at vger.kernel.org
> > Subject: build failure of next-20220829 due to 108713a713c7 ("crypto: aspeed
> > - Add HACE hash driver")
> >
> > Hi All,
> >
> > The builds of arm allmodconfig have failed to build next-20220829 with the
> > error:
> >
> > ERROR: modpost: "aspeed_register_hace_hash_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_unregister_hace_crypto_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_register_hace_crypto_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> > ERROR: modpost: "aspeed_unregister_hace_hash_algs"
> > [drivers/crypto/aspeed/aspeed_crypto.ko] undefined!
> >
> >
> > git bisect pointed to 108713a713c7 ("crypto: aspeed - Add HACE hash driver")
> >
> > I will be happy to test any patch or provide any extra log if needed.
> >
> >
> > --
> > Regards
> > Sudip
>
> Hi Sudip,
>
> I already sent another patch to fix this build error, could you give it a try?
> https://lkml.org/lkml/2022/8/29/131

Thanks, that has fixed the failure.


-- 
Regards
Sudip
