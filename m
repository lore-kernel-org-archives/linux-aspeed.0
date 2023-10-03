From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 03 Oct 2023 17:52:33 +1030
Subject: [PATCH 3/3] mctp: Add MCTP-over-KCS transport binding
In-Reply-To: <20230929120835.0000108e@Huawei.com>
References: <20230928123009.2913-1-aladyshev22@gmail.com>
 <20230928123009.2913-4-aladyshev22@gmail.com>
 <20230929120835.0000108e@Huawei.com>
Message-ID: <1fd97872-446e-42f3-84ad-6e490d63e12d@app.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On Fri, 29 Sep 2023, at 20:38, Jonathan Cameron wrote:
> On Thu, 28 Sep 2023 15:30:09 +0300
> Konstantin Aladyshev <aladyshev22@gmail.com> wrote:
>
>> This change adds a MCTP KCS transport binding, as defined by the DMTF
>> specificiation DSP0254 - "MCTP KCS Transport Binding".
>> A MCTP protocol network device is created for each KCS channel found in
>> the system.
>> The interrupt code for the KCS state machine is based on the current
>> IPMI KCS driver.
>> 
>> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
>
> Drive by review as I was curious and might as well comment whilst reading.
> Some comments seem to equally apply to other kcs drivers so maybe I'm
> missing something...
>

I doubt you're missing anything. I reworked the KCS stuff a while back to make it a bit more general. Prior to Konstantin's work here the subsystem lived in its own little dark corner and might have benefitted from broader review. Some of the concerns with Konstantin's work are likely concerns with what I'd done, which he probably used as a guide. For reference the rework series is here:

https://lore.kernel.org/all/20210608104757.582199-1-andrew at aj.id.au/

>> +
>> +static DEFINE_SPINLOCK(kcs_bmc_mctp_instances_lock);
>> +static LIST_HEAD(kcs_bmc_mctp_instances);
> As mentioned below, this seems to be only used to find some data again
> in remove. Lots of cleaner ways to do that than a list in the driver.
> I'd explore the alternatives.

Yeah, it's a little clumsy. I'll look into better ways to address the problem.

> 
>> +	if (!ndev) {
>> +		dev_err(kcs_bmc->dev,
>> +			"alloc_netdev failed for KCS channel %d\n",
>> +			kcs_bmc->channel);
> No idea if the kcs subsystem handles deferred probing right, but in general
> anything called just in 'probe' routines can use dev_err_probe() to pretty
> print errors and also register any deferred cases with the logging stuff that
> lets you find out why they were deferred.

Let me see if there's work to do in the KCS subsystem to deal with deferred probing. I expect that there is.

>
>
>> +	if (rc)
>> +		goto free_netdev;
>> +
>> +	spin_lock_irq(&kcs_bmc_mctp_instances_lock);
>> +	list_add(&mkcs->entry, &kcs_bmc_mctp_instances);
>
> Add a callback and devm_add_action_or_reset() to unwind this as well.

I'll check the other KCS users as well.

>
>
>
>> +	devm_kfree(kcs_bmc->dev, mkcs->data_in);
>> +	devm_kfree(kcs_bmc->dev, mkcs->data_out);
>
> Alarm bells occur whenever an explicit devm_kfree turns up in
> except in complex corner cases. Please look at how devm based
> resource management works. These should not be here.

Ah, I think this was an oversight in how I reworked the drivers a while back. I changed the arrangement of the structures but retained the devm_* approach to resource management. Let me page the KCS stuff back in so I can clean that up.

>
> Also, remove_device should either do things in the opposite order
> to add_device, or it should have comments saying why not!

+1

>
>
>> +	return 0;
>> +}
>> +
>> +static const struct kcs_bmc_driver_ops kcs_bmc_mctp_driver_ops = {
>> +	.add_device = kcs_bmc_mctp_add_device,
>> +	.remove_device = kcs_bmc_mctp_remove_device,
>> +};
>> +
>> +static struct kcs_bmc_driver kcs_bmc_mctp_driver = {
>> +	.ops = &kcs_bmc_mctp_driver_ops,
>> +};
>> +
>> +static int __init mctp_kcs_init(void)
>> +{
>> +	kcs_bmc_register_driver(&kcs_bmc_mctp_driver);
>> +	return 0;
>> +}
>> +
>> +static void __exit mctp_kcs_exit(void)
>> +{
>> +	kcs_bmc_unregister_driver(&kcs_bmc_mctp_driver);
>> +}
>
> Hmm. So kcs is a very small subsystem hence no one has done the usual
> module_kcs_driver() wrapper (see something like module_i2c_driver)
> for an example. 

I'll probably deal with this in the course of the rest of the poking around.

Thanks for the drive-by comments!

Andrew
