From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 17 Dec 2020 02:46:33 -0800
Subject: [PATCH 2/2] media: aspeed: fix clock handling logic
In-Reply-To: <d3faea9e-e7d6-eba0-a6b2-c30bc9b6e147@linux.intel.com>
References: <20201207164240.15436-1-jae.hyun.yoo@linux.intel.com>
 <20201207164240.15436-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xd3dz1WLGNGqMiAZxhMEeGHbkPtvO2rYQ36Kbj=Uvy-jA@mail.gmail.com>
 <d3faea9e-e7d6-eba0-a6b2-c30bc9b6e147@linux.intel.com>
Message-ID: <160820199393.1580929.9806429719720580479@swboyd.mtv.corp.google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Jae Hyun Yoo (2020-12-08 09:16:29)
> Hi Joel,
> 
> On 12/7/2020 6:39 PM, Joel Stanley wrote:
> > On Mon, 7 Dec 2020 at 16:33, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> >>
> >> Video engine uses eclk and vclk for its clock sources and its reset
> >> control is coupled with eclk so the current clock enabling sequence works
> >> like below.
> >>
> >>   Enable eclk
> >>   De-assert Video Engine reset
> >>   10ms delay
> >>   Enable vclk
> > 
> > This is the case after " clk: ast2600: fix reset settings for eclk and
> > vclk" is applied, correct? Without that patch applied the reset
> > sequence is correct by accident for the 2600, but it will be wrong for
> > the 2500?
> 
> Correct. Video Engine reset was coupled with eclk for AST2500 and vclk
> for AST2600 so above sequence was observed only in AST2500. As you said,
> AST2600 didn't make the issue by accident but the clk/reset pair should
> be fixed by this patch series.

So should the two patches be squashed together and go through the
media tree?
