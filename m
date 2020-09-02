From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 2 Sep 2020 10:47:18 -0500
Subject: [PATCH 2/5] input: misc: Add IBM Operation Panel driver
In-Reply-To: <20200901061108.GB1148@ninjato>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
 <20200820161152.22751-3-eajames@linux.ibm.com>
 <20200901061108.GB1148@ninjato>
Message-ID: <796de8d4-6771-a8da-ea93-6e7e08aa93b0@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 9/1/20 1:11 AM, Wolfram Sang wrote:
>> +	switch (event) {
>> +	case I2C_SLAVE_STOP:
>> +		command_size = panel->idx;
>> +		fallthrough;
>> +	case I2C_SLAVE_WRITE_REQUESTED:
>> +		panel->idx = 0;
>> +		break;
>> +	case I2C_SLAVE_WRITE_RECEIVED:
>> +		if (panel->idx < sizeof(panel->command))
>> +			panel->command[panel->idx++] = *val;
>> +		else
>> +			dev_dbg(&panel->input->dev, "command truncated\n");
> Just double checking: Do you really want to process truncated commands?
> Since you detect the state here, you could also choose to reject such
> commands?


Yes I suppose not. It could still be a valid command with extra bytes, 
but unlikely, so probably better not to handle it.


Thanks,

Eddie


>
