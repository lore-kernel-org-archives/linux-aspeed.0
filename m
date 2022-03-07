From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 7 Mar 2022 15:31:13 +0700
Subject: [PATCH v6 5/9] regmap: Introduces regmap lock helpers
In-Reply-To: <YcXI73GKNdx/gvUb@sirena.org.uk>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-6-quan@os.amperecomputing.com>
 <YcXI73GKNdx/gvUb@sirena.org.uk>
Message-ID: <b5976993-aee0-b5f3-2762-8066d7f083d1@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 24/12/2021 20:19, Mark Brown wrote:
> On Fri, Dec 24, 2021 at 11:13:48AM +0700, Quan Nguyen wrote:
>> This commit introduces regmap_acquire/release_lock() functions and makes
>> them available for drivers that need atomic access of regmap registers
> 
> You've not explained what something would need this for and how
> it's expected to work - we don't provide unlocked access to the
> regmap to client drivers so I don't see how one could safely use
> this.  It's unclear to me what this would mean or why it's not
> better implemented in the client driver.

Thanks a lot for the review, Mark.
As per my comment in the other email, this code will be removed in my 
next version.

Thanks,
- Quan
