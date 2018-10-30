From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Oct 2018 15:20:13 -0700
Subject: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Tue, Oct 30, 2018 at 4:56 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
>
> Indeed.
>
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
>
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

Yes, sorry about the mess.  Splitting this into two series makes the
most sense.  Then I can focus more on trying to get the CCs right and
people can just get the patches that matter to them.

OK, I've sent v2 of both series out now.  Please yell if you can't
find them for whatever reason.

-Doug

-Doug
