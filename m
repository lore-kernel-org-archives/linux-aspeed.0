From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
Date: Wed, 23 Oct 2019 21:34:39 +0000
Subject: [PATCH v2 04/22] mtd: spi-nor: Rename nor->params to nor->flash
In-Reply-To: <20191010090524.6de7e746@dhcp-172-31-174-146.wireless.concordia.ca>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-5-tudor.ambarus@microchip.com>
 <20191010090524.6de7e746@dhcp-172-31-174-146.wireless.concordia.ca>
Message-ID: <9c57cd8b-d797-f2a9-0235-792a0e730090@microchip.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/10/2019 10:05 AM, Boris Brezillon wrote:
> External E-Mail
> 
> 
> On Tue, 24 Sep 2019 07:46:03 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
>> From: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Rename nor->params to nor->flash for a clearer separation
>> between the controller and flash operations.
> 
> Hm, I'm not sure 'flash' is clearer than 'params', and the spi_nor
> object is supposed to represent the NOR chip anyway, so it was pretty
> clear to me that nor->params were the NOR flash parameters not the
> NOR controller ones.
> If I had anything to change it would be s/params/properties/ (and
> s/spi_nor_flash_parameter/spi_nor_properties/) since those parameters
> look like immutable information discovered during the NOR detection,
> but I'm nitpicking here.
>

I'll drop this for now.
