From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Jul 2021 12:34:58 -0700
Subject: [PATCH 00/14] Introduce PECI subsystem
In-Reply-To: <fe9a5191e401b38325aaff11365b5970034d26cc.camel@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <3b9cfe5f728c40c473a22070029c8790b452daf4.camel@intel.com>
 <fe9a5191e401b38325aaff11365b5970034d26cc.camel@intel.com>
Message-ID: <CAPcyv4h-PrBhPU7FcuKwk++o5unKY03H85M-inpDGvmDh-ybGQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 15, 2021 at 10:33 AM Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
>
> On Wed, 2021-07-14 at 16:51 +0000, Williams, Dan J wrote:
> > On Tue, 2021-07-13 at 00:04 +0200, Iwona Winiarska wrote:
> > > Note: All changes to arch/x86 are contained within patches 01-02.
> >
> > Hi Iwona,
> >
> > One meta question first, who is this submission "To:"? Is there an
> > existing upstream maintainer path for OpenBMC changes? Are you
> > expecting contributions to this subsystem from others? While Greg
> > sometimes ends up as default maintainer for new stuff, I wonder if
> > someone from the OpenBMC commnuity should step up to fill this role?
> >
>
> The intention was to direct it to Greg, but I guess I didn't express
> that through the mail headers.

Usually something like a "Hey Greg, please consider applying..." in
the cover letter lets people know who the upstream path is for the
series.

> I am expecting contributions - for example there is at least one other
> major BMC vendor which also ships PECI controllers.

You're expecting to take patches from them and you'll forward them to
Greg, or they'll go to Greg directly?

>
> From my perspective, the pieces that make up a BMC are pretty loosely
> connected (at least from the kernel perspective - scattered all over
> the kernel tree), so I don't see how that would work in practice.

No worries, Greg continues to scale more than other mere mortals for
these kinds of things. I was more asking because it was not clear from
these patches, nor MAINTAINERS, and it's healthy for Linux to grow new
patch wranglers from time to time.
