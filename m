From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 30 Apr 2024 11:08:17 +0930
Subject: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
In-Reply-To: <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
	 <20240428142937.785925-2-peteryin.openbmc@gmail.com>
	 <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
	 <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
Message-ID: <e694ba58197687dce68d568dfcb078ff3a6c6fed.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-04-29 at 22:54 +0800, Peter Yin wrote:
> Hi Andrew,
>     I am not sure how to add the Fixes tag, Is it like this?
> 
> Fixes: 6a6c7b006e5c (watchdog: aspeed: Add support for
> aspeed,reset-mask DT property).

Approximately, yes, but it must not be wrapped.

Some more info is provided in the submitting-patches documentation:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> 
> Is it the correct commit ID or should I base on which commit ID?
> 

The correct commit ID to use is the one that introduces the problem.
Using `git blame drivers/watchdog/aspeed_wdt.c` it appears you're
changing the behaviour that was introduced in 49d4d277ca54 ("aspeed:
watchdog: Set bootstatus during probe"):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=49d4d277ca54e04170d39484c8758a0ea9bca37d

Andrew
