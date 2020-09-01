From: Wolfram Sang <wsa@kernel.org>
Date: Tue, 1 Sep 2020 08:11:39 +0200
Subject: [PATCH 4/5] ARM: dts: Aspeed: Tacoma: Add IBM Operation Panel
 I2C device
In-Reply-To: <CACPK8XfeKiee-LAQZXs6jygr1Bj7pqGTGLUnTV1mzO5FBZ-XZQ@mail.gmail.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-5-eajames@linux.ibm.com>
 <CACPK8XfeKiee-LAQZXs6jygr1Bj7pqGTGLUnTV1mzO5FBZ-XZQ@mail.gmail.com>
Message-ID: <20200901061139.GC1148@ninjato>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> > +       ibm-panel at 62 {
> > +               compatible = "ibm,op-panel";
> > +               reg = <0x40000062>; /* I2C_OWN_SLAVE_ADDRESS */
> 
> Other users of SLAVE_ADDRESS have included <dt-bindings/i2c/i2c.h> and
> written the reg as follows:
> 
> reg = <(I2C_OWN_SLAVE_ADDRESS | 0x62)>
> 
> Which obviously has the same result. I'll leave it up to you.

The latter, please.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200901/c7ad5023/attachment-0001.sig>
