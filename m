From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 25 Mar 2019 17:10:10 +0100
Subject: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
In-Reply-To: <CACPK8XfFTF2hDzwO33gE=fotEEC-CZztThoaYj98Le9JAsAQ-w@mail.gmail.com>
References: <20190325133159.10653-1-joel@jms.id.au>
 <20190325133159.10653-3-joel@jms.id.au>
 <20190325145954.GM30105@piout.net>
 <CACPK8XfFTF2hDzwO33gE=fotEEC-CZztThoaYj98Le9JAsAQ-w@mail.gmail.com>
Message-ID: <20190325161010.GP30105@piout.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 25/03/2019 15:28:26+0000, Joel Stanley wrote:
> On Mon, 25 Mar 2019 at 14:59, Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hi,
> >
> > This seems mostly good to me.
> >
> > On 26/03/2019 00:01:59+1030, Joel Stanley wrote:
> > > +     dev_dbg(dev, "%s: %4d-%02d-%02d %02d:%02d:%02d\n", __func__,
> > > +                     1900 + tm->tm_year, tm->tm_mon + 1, tm->tm_mday,
> > > +                     tm->tm_hour, tm->tm_min, tm->tm_sec);
> > > +
> >
> > We now have %ptR, could you use that?
> 
> I tried this:
> 
>   dev_dbg(dev, "%s: %ptR", __func__, tm);
> 
> Yes, that appears to do the job. Can you make the change when applying?
> 

While doing that change, I relaized that the whole locking is probably
unnecessary as all the rtc_ops are called with the rtc lock taken. If
you are not planning to add alarm support, the lock can be removed.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
