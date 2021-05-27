From: Steven Lee <steven_lee@aspeedtech.com>
Date: Thu, 27 May 2021 10:43:41 +0800
Subject: [PATCH v2 0/4] ASPEED sgpio driver enhancement.
In-Reply-To: <4d995f6e-b582-4f45-b87c-2cd795de8d14@www.fastmail.com>
References: <20210527005455.25758-1-steven_lee@aspeedtech.com>
 <4d995f6e-b582-4f45-b87c-2cd795de8d14@www.fastmail.com>
Message-ID: <20210527024341.GB9971@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/27/2021 09:41, Andrew Jeffery wrote:
> Hi Steven,
> 
> On Thu, 27 May 2021, at 10:24, Steven Lee wrote:
> > AST2600 SoC has 2 SGPIO master interfaces one with 128 pins another one
> > with 80 pins, AST2500/AST2400 SoC has 1 SGPIO master interface that
> > supports up to 80 pins.
> > In the current driver design, the max number of sgpio pins is hardcoded
> > in macro MAX_NR_HW_SGPIO and the value is 80.
> > 
> > For supporting sgpio master interfaces of AST2600 SoC, the patch series
> > contains the following enhancement:
> > - Convert txt dt-bindings to yaml.
> > - Update aspeed dtsi to support the enhanced sgpio.
> > - Get the max number of sgpio that SoC supported from dts.
> > - Support muiltiple SGPIO master interfaces.
> > - Support up to 128 pins.
> > 
> > Changes from v1:
> > * Fix yaml format issues.
> > * Fix issues reported by kernel test robot.
> > 
> > Please help to review.
> 
> I think it's worth leaving a little more time between sending series.
> 
> I've just sent a bunch of reviews on v1.
> 

I am worried about the patch series may be drop by reviewers due to
the report of kernel test robot.

Regardless, thanks for the comment in v1 patch series.

Steven

> Cheers,
> 
> Andrew
