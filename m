From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 04 Oct 2024 10:09:36 +0930
Subject: [PATCH v3 0/9] Add I2C mux devices for yosemite4
In-Reply-To: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
References: <20241003074251.3818101-1-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <172800237675.81323.9277417561111727144.b4-ty@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 15:42:41 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> - v3
>  - Merge the remove mctp property patch to patch 02.
>  - Order the patch to correct compatible string of max31790 before patch
>    06.
> - v2
>  - Remove mctp property on I2C Bus 15.
>  - Add required properties for IOE on fan boards.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>

