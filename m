From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 3 Oct 2022 09:06:46 +0700
Subject: [PATCH v9 3/3] i2c: aspeed: Assert NAK when slave is busy
In-Reply-To: <YzjFRrCRZBAaSRBL@shikoro>
References: <20220929080326.752907-1-quan@os.amperecomputing.com>
 <20220929080326.752907-4-quan@os.amperecomputing.com>
 <YzjFRrCRZBAaSRBL@shikoro>
Message-ID: <b35f756d-08e7-6eed-5992-ad63ee419e1f@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 02/10/2022 05:55, Wolfram Sang wrote:
> 
>> +		if (ret == -EBUSY)
> 
> Since we documented this:
> 
> "+  'ret': 0 if the backend is ready, otherwise some errno"
> 
> the code above should be '(ret < 0)'
> 

Will update.
Thanks a lot for the review.

- Quan
