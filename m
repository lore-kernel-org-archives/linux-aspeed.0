From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 11 Oct 2022 12:02:50 +0300
Subject: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
In-Reply-To: <CAMRc=Mc5t=R2pJYfHUntJj_UA3sL=sKGOQDL-Kf5=dfNJEKyvg@mail.gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mc5t=R2pJYfHUntJj_UA3sL=sKGOQDL-Kf5=dfNJEKyvg@mail.gmail.com>
Message-ID: <Y0UxOrhpsHngiuAk@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 09:10:07AM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > than logical. This series is basically out of two parts:
> > - add missed headers to the pin control drivers / users
> > - clean up the headers of pin control subsystem
> >
> > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > pin control subsystems, so all new drivers will utilize cleaned up headers
> > of the pin control.
> >
> > Please, review and comment.
> >
> > Changelog v2:
> > - added preparatory patches: all, but last (LKP)
> > - added missed forward declaration to the last patch (LKP)
> 
> Thanks for doing this.

You're welcome!

> Did you use any kind of automation for
> detecting for which symbols the headers are missing?

No, it's manual + what CI(s) reported back to me, that's why even in this
series I have got a few compile breakages. I have very limited compile-testing
cycle.

-- 
With Best Regards,
Andy Shevchenko


