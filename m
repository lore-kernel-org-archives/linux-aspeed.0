From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Feb 2023 15:40:56 +0200 (EET)
Subject: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com> <34e3729f-9266-3606-9f11-33222f50e753@molgen.mpg.de>
Message-ID: <95c8a699-7293-8d89-222-a69c56da08f@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 10 Feb 2023, Paul Menzel wrote:

> > +MODULE_LICENSE("GPL");
> 
> Should it be GPL v2?

No, it should. "GPL" is the correct for in MOUDLE_LICENSE(). SPDX lines 
are a different thing and more precise.

-- 
 i.

