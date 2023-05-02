From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 2 May 2023 14:01:01 -0500
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <45bc13a8-1442-2dd3-b9ea-1ed2f5962bac@arm.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <4ff4f171-c5f8-87af-aad1-5e7686292288@microchip.com> <45bc13a8-1442-2dd3-b9ea-1ed2f5962bac@arm.com>
Message-ID: <CAL_JsqL7t47x-5U6STynwW-+4wJUhs_R9wuaQ0YOgX59aJ=vew@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Apr 25, 2023 at 11:21?AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 29/03/2022 9:50 am, Nicolas Ferre wrote:
> > Ansuel, All,
> >
> > On 28/03/2022 at 10:55, Daniel Palmer wrote:
> >> Hi Ansuel
> >>
> >> On Mon, 28 Mar 2022 at 09:09, Ansuel Smith <ansuelsmth@gmail.com> wrote:
> >>>
> >>> Hi,
> >>> as the title say, the intention of this ""series"" is to finally
> >>> categorize
> >>> the ARM dts directory in subdirectory for each oem.
> >>
> >> While I agree with this change and think it's for the good (browsing
> >> the ARM dts directory at the moment is frustrating..) I think
> >> buildroot and others need to be told about this as it'll potentially
> >> break their kernel build scripting for ARM and probably messes up the
> >> configs they have for existing boards.
> >
> > This aspect mustn't be underestimated and I anticipate lots of issues
> > during a long time on this particular topic of "build systems".
> >
> > Another aspect is CI and public or private testing farms we all have
> > running.
>
> Yet another is if this affects what `make dtbs_install` does (I don't
> know for sure, but I'd be inclined to suspect it might). Some distros
> use that to deliver the DTBs as part of their kernel package, so if
> paths suddenly change it could break end users' bootloader setups too.

Indeed, this came up last time. Turns out I had already implemented
support to maintain the flat install. I just re-wrote it since
Makefile.dtbinst changed completely since then.

Rob
