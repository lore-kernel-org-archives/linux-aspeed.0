From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 22 Nov 2023 12:48:12 +0200
Subject: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
In-Reply-To: <20231122014212.304254-1-chentao@kylinos.cn>
References: <20231122014212.304254-1-chentao@kylinos.cn>
Message-ID: <ZV3cbH-i09AQelaB@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.

OK.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


