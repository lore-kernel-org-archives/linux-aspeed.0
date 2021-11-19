From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 19 Nov 2021 09:44:47 +0800
Subject: [PATCH v5 02/10] media: aspeed: use v4l2_info/v4l2_warn/v4l2_dbg
 for log
In-Reply-To: <YZY/VCt8WZx/4dFt@paasikivi.fi.intel.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <20211118074030.685-3-jammy_huang@aspeedtech.com>
 <YZY/VCt8WZx/4dFt@paasikivi.fi.intel.com>
Message-ID: <421745ba-0311-4556-b6e0-555bb8b3d9eb@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 2021/11/18 ?? 07:56, Sakari Ailus wrote:
> Hi Jammy,
>
> On Thu, Nov 18, 2021 at 03:40:23PM +0800, Jammy Huang wrote:
>> The debug log level, 0~3, is controlled by module_param, debug.
>> The higher the value, the more the information.
>>    0: off
>>    1: info
>>    2: debug
>>    3: register operations
>>
>> Signed-off-by: Jammy Huang<jammy_huang@aspeedtech.com>
> Just wondering: what's the purpose of switching to v4l2_*() functions for
> printing when dev_*() equivalents already can do the same?
>
Indeed, most of them, such as dev_err/v4l2_err or dev_info/v4l2_info, are the same.
The reason why I want to adapt v4l2_*() is v4l2_dbg with which I can have module's
own debug level.
/* These three macros assume that the debug level is set with a module
parameter called 'debug'. */
#define v4l2_dbg 
<https://elixir.bootlin.com/linux/latest/C/ident/v4l2_dbg>(level 
<https://elixir.bootlin.com/linux/latest/C/ident/level>, debug 
<https://elixir.bootlin.com/linux/latest/C/ident/debug>, dev, fmt 
<https://elixir.bootlin.com/linux/latest/C/ident/fmt>, arg...) \
do { \
if (debug <https://elixir.bootlin.com/linux/latest/C/ident/debug> >= 
(level <https://elixir.bootlin.com/linux/latest/C/ident/level>)) \
v4l2_printk 
<https://elixir.bootlin.com/linux/latest/C/ident/v4l2_printk>(KERN_DEBUG 
<https://elixir.bootlin.com/linux/latest/C/ident/KERN_DEBUG>, dev, fmt 
<https://elixir.bootlin.com/linux/latest/C/ident/fmt> , ## arg); \
} while (0)
-- 
Best Regards
Jammy
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20211119/dc43246f/attachment.htm>
