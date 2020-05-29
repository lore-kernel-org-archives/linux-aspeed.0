From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2020 11:52:33 -0700
Subject: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200529174210.GF17541@heinlein>
References: <20200529124607.GA3469@cnn>
 <49485085-7cc7-9e29-a719-98d1e184378b@roeck-us.net>
 <20200529174210.GF17541@heinlein>
Message-ID: <356db3d6-bc56-bd58-428f-d8e94311abee@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 5/29/20 10:42 AM, Patrick Williams wrote:
> Hi Guenter,
> 
> Thanks for the initial look at this.
> 
> One question for you below...
> 
> On Fri, May 29, 2020 at 10:30:16AM -0700, Guenter Roeck wrote:
>> On 5/29/20 5:46 AM, Manikandan Elumalai wrote:
>>> +		/* Enable TEMP1 by default */
>>> +		config |= ADM1278_TEMP1_EN;
>>> +		ret = i2c_smbus_write_byte_data(client,
>>> +					ADM1275_PMON_CONFIG,
>>> +					config);
>>> +		if (ret < 0) {
>>> +		dev_err(&client->dev,
>>> +			"Failed to enable temperature config\n");
>>> +		return -ENODEV;
>>> +		}
>>
>> This can be handled in a single operation, together with ADM1278_VOUT_EN
>> below. There is no need for two separate write operations.
> 
> I don't know if you noticed here but the change ends up enabling
> TEMP1_EN in all cases.  Is this acceptable?  If not, do you have any
> preference on how it is selected for enablement?
> 

I did. We are doing the same for output voltage already, so I am not that
much concerned about it. If it is, we might consider adding _enable
attribute support (see Documentation/hwmon/sysfs-interface.rst) to the
PMBus core (presumably as virtual PMBus commands) and let the user
enable/disable individual attributes as needed.

What _should_ really be done, of course, is that the BIOS/ROMMON
configures the chip as desired. Obviously that is not happening here.

Guenter

>>>  		/* Enable VOUT if not enabled (it is disabled by default) */
>>>  		if (!(config & ADM1278_VOUT_EN)) {
>>> @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
>>>  			}
>>>  		}
>>>  
>>> -		if (config & ADM1278_TEMP1_EN)
>>> -			info->func[0] |=
>>> -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>>>  		if (config & ADM1278_VIN_EN)
>>>  			info->func[0] |= PMBUS_HAVE_VIN;
>>>  		break;
>>>
>>
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200529/64248c86/attachment.sig>
