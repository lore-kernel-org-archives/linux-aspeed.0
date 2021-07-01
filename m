From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 01 Jul 2021 14:38:48 +0930
Subject: [PATCH] ARM: dts: tacoma: Add phase corrections for eMMC
In-Reply-To: <CACPK8Xd9tsMJaQ9BQSGL0Vfi4UpJ1iuOtMVmfKneydd-zYBhsw@mail.gmail.com>
References: <20210625061017.1149942-1-andrew@aj.id.au>
 <CACPK8Xd9tsMJaQ9BQSGL0Vfi4UpJ1iuOtMVmfKneydd-zYBhsw@mail.gmail.com>
Message-ID: <f13125b1-3af6-4cd4-895b-4d98bf78b568@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 1 Jul 2021, at 13:10, Joel Stanley wrote:
> On Fri, 25 Jun 2021 at 06:10, Andrew Jeffery <andrew@aj.id.au> wrote:
> >
> > The degree values were reversed out from the magic tap values of 7 (in)
> > and 15 + inversion (out) initially suggested by Aspeed.
> >
> > With the patch tacoma survives several gigabytes of reads and writes
> > using dd while without it locks up randomly during the boot process.
> >
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Thanks for the fix. Is this required due to "mmc: sdhci-of-aspeed: Add
> AST2600 bus clock support" or "mmc: sdhci-of-aspeed: Expose clock
> phase controls"?

Sort of neither, it's really a bug with the devicetrees.

> 
> On the topic of those patches, it would be good if we could operate
> the devices (with the slower speed?) when the device tree does not
> provide the phase values. Think about system bringup, or where you
> need the system booting in order to determine the phase calculations.

You can use the maximum-frequency binding to make things go slow enough 
to paper over phase issues. This helped us limp along early on.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/mmc/mmc-controller.yaml?h=v5.13#n90

But really it depends on how bad the issues are at a given speed.

> 
> What changes would be required to the host driver for it to work out of the box?

Maybe the above is enough of a crutch?

Andrew
