From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 03 Apr 2020 14:20:21 +1030
Subject: =?UTF-8?Q?Re:_[PATCH_v2_0/3]_ipmi:_kcs-bmc:_Rework_bindings_to_clean_up_?=
 =?UTF-8?Q?DT_warnings?=
In-Reply-To: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
References: <cover.fe20dfec1a7c91771c6bb574814ffb4bb49e2136.1576462051.git-series.andrew@aj.id.au>
Message-ID: <7734002a-181e-4baf-b9a3-af66894acc16@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 16 Dec 2019, at 12:57, Andrew Jeffery wrote:
> Hello,
> 
> This is a short series reworking the devicetree binding and driver for the
> ASPEED BMC KCS devices. With the number of supported ASPEED BMC devicetrees the
> changes enable removal of more than 100 lines of warning output from dtc.
> 
> v1 can be found here:
> 
> https://lore.kernel.org/lkml/cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew at aj.id.au/
> 
> v2 cleans up the commit message of 2/3 and changes the name of the property
> governing the LPC IO address for the KCS devices.

Ping?
