From: Andi Shyti <andi.shyti@kernel.org>
Date: Mon, 5 Aug 2024 19:30:20 +0200
Subject: [PATCH] i2c: don't use ',' after delimiters
In-Reply-To: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
References: <20240730220401.3649-2-wsa+renesas@sang-engineering.com>
Message-ID: <gipvrndaja55f2fh3iwjvcenvdbizuzwrkcf6wow3c2y3pimgr@vorn7q2snn2o>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Wolfram,

On Wed, Jul 31, 2024 at 12:01:59AM GMT, Wolfram Sang wrote:
> Delimiters are meant to be last, no need for a ',' there. Remove a
> superfluous newline in the ali1535 driver while here.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

pushed into i2c/i2c-host.

Thanks,
Andi
