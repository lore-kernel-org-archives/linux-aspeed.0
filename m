From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 29 May 2020 17:57:03 +0000
Subject: [PATCH v2] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN 
In-Reply-To: <20200529124607.GA3469@cnn>
References: <20200529124607.GA3469@cnn>
Message-ID: <6F5BD2D3-997D-4607-BC0C-B36497B51D13@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



?On 5/29/20, 5:47 AM, "Manikandan Elumalai" <manikandan.hcl.ers.epl@gmail.com> wrote:

    The adm1278 temperature sysfs attribute need it for one of the openbmc platform . 
    This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.
    
    Signed-off-by   : Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
    
    v2:
       - Add Signed-off-by.
       - Removed ADM1278_TEMP1_EN check.
    ---
     drivers/hwmon/pmbus/adm1275.c | 21 +++++++++++++++++----
     1 file changed, 17 insertions(+), 4 deletions(-)
    
    diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
    index 5caa37fb..ab5fceb 100644
    --- a/drivers/hwmon/pmbus/adm1275.c
    +++ b/drivers/hwmon/pmbus/adm1275.c
    @@ -666,7 +666,23 @@ static int adm1275_probe(struct i2c_client *client,
     		tindex = 3;
     
     		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
    -			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
    +			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
    +			PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
    +
    +		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
    +		if (config < 0)
    +			return config;
    +
    +		/* Enable TEMP1 by default */
    +		config |= ADM1278_TEMP1_EN;
    +		ret = i2c_smbus_write_byte_data(client,
    +					ADM1275_PMON_CONFIG,
    +					config);
    +		if (ret < 0) {
    +		dev_err(&client->dev,
    +			"Failed to enable temperature config\n");
    +		return -ENODEV;
    +		}
You don't need this above code removing check as below should be enough  to
populate sysfs entry you need.

     		/* Enable VOUT if not enabled (it is disabled by default) */
     		if (!(config & ADM1278_VOUT_EN)) {
    @@ -681,9 +697,6 @@ static int adm1275_probe(struct i2c_client *client,
     			}
     		}
     
    -		if (config & ADM1278_TEMP1_EN)
    -			info->func[0] |=
    -				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
     		if (config & ADM1278_VIN_EN)
     			info->func[0] |= PMBUS_HAVE_VIN;
     		break;
    -- 
    2.7.4
    
    

