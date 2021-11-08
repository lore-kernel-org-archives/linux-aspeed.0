From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 08 Nov 2021 10:51:48 +1030
Subject: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
In-Reply-To: <HK0PR06MB27861518CA84A9DC8D204AC1B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
 <5a235916-f250-48ac-b931-6ec2c5c2ea5d@www.fastmail.com>
 <HK0PR06MB27861518CA84A9DC8D204AC1B28F9@HK0PR06MB2786.apcprd06.prod.outlook.com>
Message-ID: <c79e93c3-1678-412f-87c5-2b757d806574@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 6 Nov 2021, at 20:32, Chin-Ting Kuo wrote:
> Hi Andrew,
>>> > -	rc = device_property_read_u32_array(dev, prop, degrees, 2);
>> > +	rc = device_property_read_u32_array(dev, prop, degrees, 4);
>> >  	phase->valid = !rc;
>> >  	if (phase->valid) {
>> > -		phase->in_deg = degrees[0];
>> > -		phase->out_deg = degrees[1];
>> > +		phase->inv_in_deg = degrees[0] ? true : false;
>> > +		phase->in_deg = degrees[1];
>> > +		phase->inv_out_deg = degrees[2] ? true : false;
>> > +		phase->out_deg = degrees[3];
>> 
>> This fundamentally breaks any in-tree users. We can't do this.
>> 
>> In terms of the binding, if negative phase values are something we must do,
>> we can just extend the value range to include [-359, -1] right?
>
> Yes, agree it and I tried it before. But, it seems that the device tree 
> doesn't support
> negative value with "-" prefixed and there is no device tree related 
> API used to get
> the negative value from .dts. Thus, I tried to add an additional flag 
> to present
> negative value.
>

Hmm. Still, I don't think we can break the binding this way.

Rob, Ulf, Adrian: What are your thoughts on handling phase offsets in 
[-360, 360] in the binding? Do we append the flag field? Add a separate 
property? I don't think interleaving the flags is desirable, though 
interested in your thoughts.

Andrew
