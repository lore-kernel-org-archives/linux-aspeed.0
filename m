From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Mon, 30 Nov 2020 09:15:46 +0000
Subject: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <20201130083345.4814-3-troy_lee@aspeedtech.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
Message-ID: <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Troy,

> Adding AST2400 and AST2600 edac driver support.
>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> ---
> drivers/edac/Kconfig       |   6 +-
> drivers/edac/aspeed_edac.c | 114 +++++++++++++++++++++++++++++--------
> 2 files changed, 94 insertions(+), 26 deletions(-)

Uh, there are quite some non-trivial changes. I'll have a look over the coming weekend.

Testing an edac driver comes with challenges. Did you test your code? If so, how?

That's how I was testing my original edac 2500 driver http://students.engr.scu.edu/~sschaeck/misc/aspeed-edac.html

 Stefan

