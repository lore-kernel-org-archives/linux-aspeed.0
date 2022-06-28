From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 28 Jun 2022 11:15:47 -0000
Subject: [PATCH v1 0/2] Fix console probe delay when stdout-path isn't set
In-Reply-To: <20220628020110.1601693-1-saravanak@google.com>
References: <20220628020110.1601693-1-saravanak@google.com>
Message-ID: <Yrrivbk2NSK3loBW@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 27, 2022 at 07:01:01PM -0700, Saravana Kannan wrote:
> Since the series that fixes console probe delay based on stdout-path[1] got
> pulled into driver-core-next, I made these patches on top of them.
> 
> Even if stdout-path isn't set in DT, this patch should take console
> probe times back to how they were before the deferred_probe_timeout
> clean up series[2].

Are you sure it's only limited to the serial drivers?
(just asking, I don't know myself the answer)

-- 
With Best Regards,
Andy Shevchenko


