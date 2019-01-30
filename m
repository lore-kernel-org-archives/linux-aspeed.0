From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 30 Jan 2019 18:01:22 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: Add peci and lpc for Facebook
In-Reply-To: <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
References: <20190123230733.1821501-1-vijaykhemka@fb.com>
 <CACPK8Xc91m9TWoRSgDCT7bVJC=C=w7mse8xbdCgw5vMVgMXM=Q@mail.gmail.com>
Message-ID: <B6DFDA82-F72C-4979-B988-05C292E61228@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 1/29/19, 7:27 PM, "Joel Stanley" <joel@jms.id.au> wrote:

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
Thanks Joel, I will be careful.
    
    Cheers,
    
    Joel
    

