From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 11 Oct 2022 18:44:34 +0300
Subject: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
In-Reply-To: <Y0WJcXzkkK4oGbrR@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
 <Y0V0IXF3sASTGdMU@smile.fi.intel.com>
 <Y0V57gI75ik4ki3A@sol>
 <Y0V9eJX7a0fe6EfX@smile.fi.intel.com>
 <CAMuHMdUhSKuJ3N5zf_+ad_dFu6kSmVTqRpgFUWtd54S9ryw=ew@mail.gmail.com>
 <Y0WJcXzkkK4oGbrR@smile.fi.intel.com>
Message-ID: <Y0WPYuZ/9//jxwQ2@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 06:19:13PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 11, 2022 at 04:39:46PM +0200, Geert Uytterhoeven wrote:

...

After all this patch is not needed. However, during checking of the necessity
of this patch I realized that seq_file is used in a few GPIO drivers without
any actual users, so I will prepare clean up series for that as well.

-- 
With Best Regards,
Andy Shevchenko


