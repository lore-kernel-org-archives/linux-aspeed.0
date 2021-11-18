From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Thu, 18 Nov 2021 13:56:04 +0200
Subject: [PATCH v5 02/10] media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg
 for log
In-Reply-To: <20211118074030.685-3-jammy_huang@aspeedtech.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <20211118074030.685-3-jammy_huang@aspeedtech.com>
Message-ID: <YZY/VCt8WZx/4dFt@paasikivi.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jammy,

On Thu, Nov 18, 2021 at 03:40:23PM +0800, Jammy Huang wrote:
> The debug log level, 0~3, is controlled by module_param, debug.
> The higher the value, the more the information.
>   0: off
>   1: info
>   2: debug
>   3: register operations
> 
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Just wondering: what's the purpose of switching to v4l2_*() functions for
printing when dev_*() equivalents already can do the same?

-- 
Sakari Ailus
