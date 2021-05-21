From: Zev Weiss <zweiss@equinix.com>
Date: Fri, 21 May 2021 07:18:43 +0000
Subject: [PATCH v3 07/16] ipmi: kcs_bmc: Strip private client data from
 struct kcs_bmc
In-Reply-To: <20210510054213.1610760-8-andrew@aj.id.au>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-8-andrew@aj.id.au>
Message-ID: <YKde0k1UCZacJFc6@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 10, 2021 at 12:42:04AM CDT, Andrew Jeffery wrote:
>Move all client-private data out of `struct kcs_bmc` into the KCS client
>implementation.
>
>With this change the KCS BMC core code now only concerns itself with
>abstract `struct kcs_bmc` and `struct kcs_bmc_client` types, achieving
>expected separation of concerns. Further, the change clears the path for
>implementation of alternative userspace interfaces.
>
>The chardev data-structures are rearranged in the same manner applied to
>the KCS device driver data-structures in an earlier patch - `struct
>kcs_bmc_client` is embedded in the client's private data and we exploit
>container_of() to translate as required.
>
>Finally, now that it is free of client data, `struct kcs_bmc` is renamed
>to `struct kcs_bmc_device` to contrast `struct kcs_bmc_client`.
>
>Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Zev Weiss <zweiss@equinix.com>
