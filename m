From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 3 May 2019 10:04:39 +0200
Subject: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
In-Reply-To: <20190501164843.GA16333@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
 <20190501164843.GA16333@roeck-us.net>
Message-ID: <c8a26b7d-2775-e13f-21b7-dbc901ea3b0b@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 01/05/2019 18:48, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
>> thermal_of_cooling_device_register() and thermal_cooling_device_register()
>> are typically called from driver probe functions, and
>> thermal_cooling_device_unregister() is called from remove functions. This
>> makes both a perfect candidate for device managed functions.
>>
>> Introduce devm_thermal_of_cooling_device_register(). This function can
>> also be used to replace thermal_cooling_device_register() by passing a NULL
>> pointer as device node. The new function requires both struct device *
>> and struct device_node * as parameters since the struct device_node *
>> parameter is not always identical to dev->of_node.
>>
>> Don't introduce a device managed remove function since it is not needed
>> at this point.
>>
> 
> Any feedback / thoughts / comments ?

Hi Guenter,

I have comments about your patch but I need some time to double check in
the current code how the 'of' and 'devm' are implemented.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

