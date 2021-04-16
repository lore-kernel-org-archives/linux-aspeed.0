From: Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Apr 2021 02:48:30 +0000
Subject: [PATCH 0/4] ARM: dts: aspeed: Rainier: Various fixes and update
In-Reply-To: <CACPK8XcvMxsFFDvrN1ueRGwFGJ55Yp4N8vNBA9tdfaa5jqzw8A@mail.gmail.com>
References: <20210413194308.36930-1-eajames@linux.ibm.com>
 <CACPK8XcvMxsFFDvrN1ueRGwFGJ55Yp4N8vNBA9tdfaa5jqzw8A@mail.gmail.com>
Message-ID: <CACPK8XfCbvibyGQyxWL7pU_nE2UOLowYVzX+fvnn7UVPxr7R4w@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 16 Apr 2021 at 02:47, Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 13 Apr 2021 at 19:43, Eddie James <eajames@linux.ibm.com> wrote:
> >
> > This series fixes a number of issues introduced in the Rainier device tree.
> > It also brings the device tree up to date with the latest hardware revision.
> >
> > Eddie James (4):
> >   ARM: dts: aspeed: Rainier: Fix PCA9552 on bus 8
> >   ARM: dts: aspeed: Rainier: Fix humidity sensor bus address
> >   ARM: dts: aspeed: Rainier 1S4U: Fix fan nodes
> >   ARM: dts: aspeed: Rainier: Update to pass 2 hardware
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> I have applied these to send to mainline.

Next time, please make sure you cc linux-arm-kernel. This way they are
archived on lore, which is how I grab the patches.
