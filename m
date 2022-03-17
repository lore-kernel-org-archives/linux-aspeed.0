From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Thu, 17 Mar 2022 16:00:08 +0700
Subject: [PATCH v6 1/4] ipmi: ssif_bmc: Add SSIF BMC driver
In-Reply-To: <7cd9301f-f417-e555-6025-74acfc53598a@quicinc.com>
References: <20220310114119.13736-1-quan@os.amperecomputing.com>
 <20220310114119.13736-2-quan@os.amperecomputing.com>
 <7cd9301f-f417-e555-6025-74acfc53598a@quicinc.com>
Message-ID: <ba91c809-ad81-1f69-cc02-3f5cf28f6350@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 15/03/2022 01:15, Jae Hyun Yoo wrote:
> Hi Quan,
> 
> [...]
> 
>> +static void on_read_requested_event(struct ssif_bmc_ctx *ssif_bmc, u8 
>> *val)
>> +{
>> +??? if (ssif_bmc->state == SSIF_READY ||
>> +??????? ssif_bmc->state == SSIF_START ||
>> +??????? ssif_bmc->state == SSIF_REQ_RECVING ||
>> +??????? ssif_bmc->state == SSIF_RES_SENDING) {
>> +??????? ssif_bmc->state = SSIF_BAD_SMBUS;
>> +??????? dev_warn(&ssif_bmc->client->dev,
>> +???????????? "Warn: %s unexpected READ REQUESTED in state=%s\n",
>> +???????????? __func__, state_to_string(ssif_bmc->state));
> 
> It will print out that the case happens in SSIF_BAD_SMBUS state always
> because ssif_bmc->state is already assigned as SSIF_BAD_SMBUS above.
> Move the assignment to after the dev_warn printing.
> 
> [...]
> 

Thanks for pointing this out. Will fix this in next version.

>> +static const struct of_device_id ssif_bmc_match[] = {
>> +??? { .compatible = "ampere,ssif-bmc" },
> 
> Does this driver have any Ampere specific handling? If not, it could be
> "ssif-bmc" as a generic SSIF driver.
> 
Will change as you suggested in next version.

>> +??? { },
>> +};
> 
> Add 'MODULE_DEVICE_TABLE(of, ssif_bmc_match);'
> 
Will do in next version
>> +
>> +static const struct i2c_device_id ssif_bmc_id[] = {
>> +??? { DEVICE_NAME, 0 },
>> +??? { },
>> +};
>> +
> 
> Remove this blank line.
> 
Will update in next version

>> +MODULE_DEVICE_TABLE(i2c, ssif_bmc_id);
>> +
>> +static struct i2c_driver ssif_bmc_driver = {
>> +??? .driver???????? = {
>> +??????? .name?????????? = DEVICE_NAME,
>> +??????? .of_match_table = ssif_bmc_match,
>> +??? },
>> +??? .probe????????? = ssif_bmc_probe,
>> +??? .remove???????? = ssif_bmc_remove,
>> +??? .id_table?????? = ssif_bmc_id,
>> +};
>> +
> 
> Remove this blank line too.
> 
> -Jae
>

Thanks Jae for the review, will update in next version.
- Quan

>> +module_i2c_driver(ssif_bmc_driver);
>> +
>> +MODULE_AUTHOR("Quan Nguyen <quan@os.amperecomputing.com>");
>> +MODULE_AUTHOR("Chuong Tran <chuong@os.amperecomputing.com>");
>> +MODULE_DESCRIPTION("Linux device driver of the BMC IPMI SSIF 
>> interface.");
>> +MODULE_LICENSE("GPL");
> 
> [...]
