From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 19 Aug 2024 10:39:25 +0930
Subject: [PATCH v12 00/28] Add i2c-mux and eeprom devices for Meta
 Yosemite 4
In-Reply-To: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240816092417.3651434-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <0935f710c5d4e306f616bb2a35bd0d75dd9e84c8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-08-16 at 17:23 +0800, Delphine CC Chiu wrote:
> Changelog:
>   - v12
>     - Fix GPIO linename typo and add missing GPIO pin initial state.

Please make sure to run `./scripts/checkpatch.pl` and `make dtbs_check`
over each patch in your series before sending it. Also, please respond
to review comments. Either acknowledge them and change your work, or
discuss the problems to get consensus on how the changes should
proceed.

Your patches will not be merged if you don't engage with the feedback
from the people reviewing them.

Finally, as it stands, the additions in the series amount to 75% of the
existing devicetree. I feel like it would be more effective to replace
it in a single patch or rename the existing devicetree out of the way,
and not try to maintain a 28-patch series. I assume all these changes
correspond to an iteration of the hardware design rather than some set
of incremental changes in their own right, in which case a new
devicetree seems appropriate.

Andrew
