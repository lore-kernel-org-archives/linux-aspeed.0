From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Mar 2019 01:00:56 +0000
Subject: [PATCH v2 2/2] rtc: Add ASPEED RTC driver
In-Reply-To: <20190325161010.GP30105@piout.net>
References: <20190325133159.10653-1-joel@jms.id.au>
 <20190325133159.10653-3-joel@jms.id.au>
 <20190325145954.GM30105@piout.net>
 <CACPK8XfFTF2hDzwO33gE=fotEEC-CZztThoaYj98Le9JAsAQ-w@mail.gmail.com>
 <20190325161010.GP30105@piout.net>
Message-ID: <CACPK8Xe0h2iVbuXApccrZD8Qxo4QEpe5Y4OgW1i7GsPfmJKbvQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2019 at 16:10, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:> >
> While doing that change, I relaized that the whole locking is probably
> unnecessary as all the rtc_ops are called with the rtc lock taken. If
> you are not planning to add alarm support, the lock can be removed.

I had a stab at alarm support, but the select() tests in rtctest.c
were failing. I will submit a v3 without the locking so we can get
that out of the way, and defer adding alarm support for now.

Cheers,

Joel
