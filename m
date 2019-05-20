From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Mon, 20 May 2019 17:21:20 +0200
Subject: [PATCH 6/6] hwmon: (pwm-fan) Use
 devm_thermal_of_cooling_device_register
In-Reply-To: <1555617500-10862-7-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-7-git-send-email-linux@roeck-us.net>
 <CGME20190520152123eucas1p1b4ea0e5743585885ba0dcbe5e6a8fd92@eucas1p1.samsung.com>
Message-ID: <a2a41672-4345-15fa-5fc1-87ca6dc575a0@samsung.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear All,

On 2019-04-18 21:58, Guenter Roeck wrote:
> Use devm_thermal_of_cooling_device_register() to register the cooling
> device. Also use devm_add_action_or_reset() to stop the fan on device
> removal, and to disable the pwm. Introduce a local 'dev' variable in
> the probe function to make the code easier to read.
>
> As a side effect, this fixes a bug seen if pwm_fan_of_get_cooling_data()
> returned an error. In that situation, the pwm was not disabled, and
> the fan was not stopped. Using devm functions also ensures that the
> pwm is disabled and that the fan is stopped only after the hwmon device
> has been unregistered.
>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


I've noticed the following lockdep warning after this commit during CPU 
hotplug tests on TM2e board (ARM64 Exynos5433). It looks like a false 
positive, but it would be nice to annotate it somehow in the code to 
make lockdep happy:

--->8---

IRQ 8: no longer affine to CPU5
CPU5: shutdown
IRQ 9: no longer affine to CPU6
CPU6: shutdown

======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc1+ #6093 Not tainted
------------------------------------------------------
cpuhp/7/43 is trying to acquire lock:
00000000d1a60be3 (thermal_list_lock){+.+.}, at: 
thermal_cooling_device_unregister+0x34/0x1c0

but task is already holding lock:
00000000a6a56c92 (&policy->rwsem){++++}, at: cpufreq_offline+0x68/0x228

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&policy->rwsem){++++}:
 ?????? down_write+0x48/0x98
 ?????? cpufreq_cpu_acquire+0x20/0x58
 ?????? cpufreq_update_policy+0x28/0xc0
 ?????? cpufreq_set_cur_state+0x44/0x70
 ?????? thermal_cdev_update+0x7c/0x240
 ?????? step_wise_throttle+0x4c/0x88
 ?????? handle_thermal_trip+0xc0/0x348
 ?????? thermal_zone_device_update.part.7+0x6c/0x250
 ?????? thermal_zone_device_update+0x28/0x38
 ?????? exynos_tmu_work+0x28/0x70
 ?????? process_one_work+0x298/0x6c0
 ?????? worker_thread+0x48/0x430
 ?????? kthread+0x100/0x130
 ?????? ret_from_fork+0x10/0x18

-> #2 (&cdev->lock){+.+.}:
 ?????? __mutex_lock+0x90/0x890
 ?????? mutex_lock_nested+0x1c/0x28
 ?????? thermal_zone_bind_cooling_device+0x2cc/0x3e0
 ?????? of_thermal_bind+0x9c/0xf8
 ?????? __thermal_cooling_device_register+0x1a4/0x388
 ?????? thermal_of_cooling_device_register+0xc/0x18
 ?????? __cpufreq_cooling_register+0x360/0x410
 ?????? of_cpufreq_cooling_register+0x84/0xf8
 ?????? cpufreq_online+0x414/0x720
 ?????? cpufreq_add_dev+0x78/0x88
 ?????? subsys_interface_register+0xa4/0xf8
 ?????? cpufreq_register_driver+0x140/0x1e0
 ?????? dt_cpufreq_probe+0xb0/0x130
 ?????? platform_drv_probe+0x50/0xa8
 ?????? really_probe+0x1b0/0x2a0
 ?????? driver_probe_device+0x58/0x100
 ?????? __device_attach_driver+0x90/0xc0
 ?????? bus_for_each_drv+0x70/0xc8
 ?????? __device_attach+0xdc/0x140
 ?????? device_initial_probe+0x10/0x18
 ?????? bus_probe_device+0x94/0xa0
 ?????? device_add+0x39c/0x5c8
 ?????? platform_device_add+0x110/0x248
 ?????? platform_device_register_full+0x134/0x178
 ?????? cpufreq_dt_platdev_init+0x114/0x14c
 ?????? do_one_initcall+0x84/0x430
 ?????? kernel_init_freeable+0x440/0x534
 ?????? kernel_init+0x10/0x108
 ?????? ret_from_fork+0x10/0x18

-> #1 (&tz->lock){+.+.}:
 ?????? __mutex_lock+0x90/0x890
 ?????? mutex_lock_nested+0x1c/0x28
 ?????? thermal_zone_bind_cooling_device+0x2b8/0x3e0
 ?????? of_thermal_bind+0x9c/0xf8
 ?????? __thermal_cooling_device_register+0x1a4/0x388
 ?????? thermal_of_cooling_device_register+0xc/0x18
 ?????? __cpufreq_cooling_register+0x360/0x410
 ?????? of_cpufreq_cooling_register+0x84/0xf8
 ?????? cpufreq_online+0x414/0x720
 ?????? cpufreq_add_dev+0x78/0x88
 ?????? subsys_interface_register+0xa4/0xf8
 ?????? cpufreq_register_driver+0x140/0x1e0
 ?????? dt_cpufreq_probe+0xb0/0x130
 ?????? platform_drv_probe+0x50/0xa8
 ?????? really_probe+0x1b0/0x2a0
 ?????? driver_probe_device+0x58/0x100
 ?????? __device_attach_driver+0x90/0xc0
 ?????? bus_for_each_drv+0x70/0xc8
 ?????? __device_attach+0xdc/0x140
 ?????? device_initial_probe+0x10/0x18
 ?????? bus_probe_device+0x94/0xa0
 ?????? device_add+0x39c/0x5c8
 ?????? platform_device_add+0x110/0x248
 ?????? platform_device_register_full+0x134/0x178
 ?????? cpufreq_dt_platdev_init+0x114/0x14c
 ?????? do_one_initcall+0x84/0x430
 ?????? kernel_init_freeable+0x440/0x534
 ?????? kernel_init+0x10/0x108
 ?????? ret_from_fork+0x10/0x18

-> #0 (thermal_list_lock){+.+.}:
 ?????? lock_acquire+0xdc/0x260
 ?????? __mutex_lock+0x90/0x890
 ?????? mutex_lock_nested+0x1c/0x28
 ?????? thermal_cooling_device_unregister+0x34/0x1c0
 ?????? cpufreq_cooling_unregister+0x78/0xd0
 ?????? cpufreq_offline+0x200/0x228
 ?????? cpuhp_cpufreq_offline+0xc/0x18
 ?????? cpuhp_invoke_callback+0xd0/0xcb0
 ?????? cpuhp_thread_fun+0x1e8/0x258
 ?????? smpboot_thread_fn+0x1b4/0x2d0
 ?????? kthread+0x100/0x130
 ?????? ret_from_fork+0x10/0x18

other info that might help us debug this:

Chain exists of:
 ? thermal_list_lock --> &cdev->lock --> &policy->rwsem

 ?Possible unsafe locking scenario:

 ?????? CPU0??????????????????? CPU1
 ?????? ----??????????????????? ----
 ? lock(&policy->rwsem);
 ?????????????????????????????? lock(&cdev->lock);
 ?????????????????????????????? lock(&policy->rwsem);
 ? lock(thermal_list_lock);

 ?*** DEADLOCK ***

3 locks held by cpuhp/7/43:
 ?#0: 00000000ae30cc2b (cpu_hotplug_lock.rw_sem){++++}, at: 
cpuhp_thread_fun+0x34/0x258
 ?#1: 00000000a0e2460a (cpuhp_state-down){+.+.}, at: 
cpuhp_thread_fun+0x178/0x258
 ?#2: 00000000a6a56c92 (&policy->rwsem){++++}, at: 
cpufreq_offline+0x68/0x228

stack backtrace:
CPU: 7 PID: 43 Comm: cpuhp/7 Not tainted 5.2.0-rc1+ #6093
Hardware name: Samsung TM2E board (DT)
Call trace:
 ?dump_backtrace+0x0/0x158
 ?show_stack+0x14/0x20
 ?dump_stack+0xc8/0x114
 ?print_circular_bug+0x1cc/0x2d8
 ?__lock_acquire+0x18f4/0x20f8
 ?lock_acquire+0xdc/0x260
 ?__mutex_lock+0x90/0x890
 ?mutex_lock_nested+0x1c/0x28
 ?thermal_cooling_device_unregister+0x34/0x1c0
 ?cpufreq_cooling_unregister+0x78/0xd0
 ?cpufreq_offline+0x200/0x228
 ?cpuhp_cpufreq_offline+0xc/0x18
 ?cpuhp_invoke_callback+0xd0/0xcb0
 ?cpuhp_thread_fun+0x1e8/0x258
 ?smpboot_thread_fn+0x1b4/0x2d0
 ?kthread+0x100/0x130
 ?ret_from_fork+0x10/0x18
IRQ 10: no longer affine to CPU7

--->8---

> ---
>   drivers/hwmon/pwm-fan.c | 73 ++++++++++++++++++++-----------------------------
>   1 file changed, 29 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 167221c7628a..0243ba70107e 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -207,33 +207,44 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>   	return 0;
>   }
>   
> +static void pwm_fan_regulator_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void pwm_fan_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
>   static int pwm_fan_probe(struct platform_device *pdev)
>   {
>   	struct thermal_cooling_device *cdev;
> +	struct device *dev = &pdev->dev;
>   	struct pwm_fan_ctx *ctx;
>   	struct device *hwmon;
>   	int ret;
>   	struct pwm_state state = { };
>   
> -	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
>   
>   	mutex_init(&ctx->lock);
>   
> -	ctx->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
> +	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
>   	if (IS_ERR(ctx->pwm)) {
>   		ret = PTR_ERR(ctx->pwm);
>   
>   		if (ret != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Could not get PWM: %d\n", ret);
> +			dev_err(dev, "Could not get PWM: %d\n", ret);
>   
>   		return ret;
>   	}
>   
>   	platform_set_drvdata(pdev, ctx);
>   
> -	ctx->reg_en = devm_regulator_get_optional(&pdev->dev, "fan");
> +	ctx->reg_en = devm_regulator_get_optional(dev, "fan");
>   	if (IS_ERR(ctx->reg_en)) {
>   		if (PTR_ERR(ctx->reg_en) != -ENODEV)
>   			return PTR_ERR(ctx->reg_en);
> @@ -242,10 +253,11 @@ static int pwm_fan_probe(struct platform_device *pdev)
>   	} else {
>   		ret = regulator_enable(ctx->reg_en);
>   		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to enable fan supply: %d\n", ret);
> +			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
>   			return ret;
>   		}
> +		devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
> +					 ctx->reg_en);
>   	}
>   
>   	ctx->pwm_value = MAX_PWM;
> @@ -257,62 +269,36 @@ static int pwm_fan_probe(struct platform_device *pdev)
>   
>   	ret = pwm_apply_state(ctx->pwm, &state);
>   	if (ret) {
> -		dev_err(&pdev->dev, "Failed to configure PWM\n");
> -		goto err_reg_disable;
> +		dev_err(dev, "Failed to configure PWM\n");
> +		return ret;
>   	}
> +	devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx->pwm);
>   
> -	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
> +	hwmon = devm_hwmon_device_register_with_groups(dev, "pwmfan",
>   						       ctx, pwm_fan_groups);
>   	if (IS_ERR(hwmon)) {
> -		dev_err(&pdev->dev, "Failed to register hwmon device\n");
> -		ret = PTR_ERR(hwmon);
> -		goto err_pwm_disable;
> +		dev_err(dev, "Failed to register hwmon device\n");
> +		return PTR_ERR(hwmon);
>   	}
>   
> -	ret = pwm_fan_of_get_cooling_data(&pdev->dev, ctx);
> +	ret = pwm_fan_of_get_cooling_data(dev, ctx);
>   	if (ret)
>   		return ret;
>   
>   	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
>   	if (IS_ENABLED(CONFIG_THERMAL)) {
> -		cdev = thermal_of_cooling_device_register(pdev->dev.of_node,
> -							  "pwm-fan", ctx,
> -							  &pwm_fan_cooling_ops);
> +		cdev = devm_thermal_of_cooling_device_register(dev,
> +			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
>   		if (IS_ERR(cdev)) {
> -			dev_err(&pdev->dev,
> +			dev_err(dev,
>   				"Failed to register pwm-fan as cooling device");
> -			ret = PTR_ERR(cdev);
> -			goto err_pwm_disable;
> +			return PTR_ERR(cdev);
>   		}
>   		ctx->cdev = cdev;
>   		thermal_cdev_update(cdev);
>   	}
>   
>   	return 0;
> -
> -err_pwm_disable:
> -	state.enabled = false;
> -	pwm_apply_state(ctx->pwm, &state);
> -
> -err_reg_disable:
> -	if (ctx->reg_en)
> -		regulator_disable(ctx->reg_en);
> -
> -	return ret;
> -}
> -
> -static int pwm_fan_remove(struct platform_device *pdev)
> -{
> -	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> -
> -	thermal_cooling_device_unregister(ctx->cdev);
> -	if (ctx->pwm_value)
> -		pwm_disable(ctx->pwm);
> -
> -	if (ctx->reg_en)
> -		regulator_disable(ctx->reg_en);
> -
> -	return 0;
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -380,7 +366,6 @@ MODULE_DEVICE_TABLE(of, of_pwm_fan_match);
>   
>   static struct platform_driver pwm_fan_driver = {
>   	.probe		= pwm_fan_probe,
> -	.remove		= pwm_fan_remove,
>   	.driver	= {
>   		.name		= "pwm-fan",
>   		.pm		= &pwm_fan_pm,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

