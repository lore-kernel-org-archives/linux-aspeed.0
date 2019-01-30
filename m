From: Joel Stanley <joel@jms.id.au>
Date: Wed, 30 Jan 2019 14:27:00 +1100
Subject: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
In-Reply-To: <20190123230733.1821501-1-vijaykhemka@fb.com>
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
Message-ID: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 24 Jan 2019 at 10:07, Vijay Khemka <vijaykhemka@fb.com> wrote:

> index 73e58a821613..d60dbb019f82 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts

>
> +&peci0 {
> +       status = "okay";
> +};

I don't think we have an upstream tree that contains a node called
peci0. Therefore this does not build.

I have dropped this hunk from your patch. Please make sure you test
before sending patches.

Cheers,

Joel
