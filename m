From: kernel test robot <lkp@intel.com>
Date: Wed, 10 Jun 2020 19:52:30 +0800
Subject: [PATCH v4] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
In-Reply-To: <20200610082611.GA14266@cnn>
References: <20200610082611.GA14266@cnn>
Message-ID: <202006101902.n2cLXU4U%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Manikandan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hwmon/hwmon-next]
[also build test WARNING on v5.7 next-20200609]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Manikandan-Elumalai/hwmon-adm1275-Enable-adm1278-ADM1278_TEMP1_EN/20200610-162820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: alpha-randconfig-r035-20200608 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/hwmon/pmbus/adm1275.c: In function 'adm1275_probe':
>> drivers/hwmon/pmbus/adm1275.c:684:14: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
684 |   if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
|              ^
>> drivers/hwmon/pmbus/adm1275.c:684:14: warning: suggest parentheses around arithmetic in operand of '|' [-Wparentheses]
684 |   if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {

vim +684 drivers/hwmon/pmbus/adm1275.c

   464	
   465	static int adm1275_probe(struct i2c_client *client,
   466				 const struct i2c_device_id *id)
   467	{
   468		u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
   469		int config, device_config;
   470		int ret;
   471		struct pmbus_driver_info *info;
   472		struct adm1275_data *data;
   473		const struct i2c_device_id *mid;
   474		const struct coefficients *coefficients;
   475		int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
   476		int tindex = -1;
   477		u32 shunt;
   478	
   479		if (!i2c_check_functionality(client->adapter,
   480					     I2C_FUNC_SMBUS_READ_BYTE_DATA
   481					     | I2C_FUNC_SMBUS_BLOCK_DATA))
   482			return -ENODEV;
   483	
   484		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, block_buffer);
   485		if (ret < 0) {
   486			dev_err(&client->dev, "Failed to read Manufacturer ID\n");
   487			return ret;
   488		}
   489		if (ret != 3 || strncmp(block_buffer, "ADI", 3)) {
   490			dev_err(&client->dev, "Unsupported Manufacturer ID\n");
   491			return -ENODEV;
   492		}
   493	
   494		ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, block_buffer);
   495		if (ret < 0) {
   496			dev_err(&client->dev, "Failed to read Manufacturer Model\n");
   497			return ret;
   498		}
   499		for (mid = adm1275_id; mid->name[0]; mid++) {
   500			if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
   501				break;
   502		}
   503		if (!mid->name[0]) {
   504			dev_err(&client->dev, "Unsupported device\n");
   505			return -ENODEV;
   506		}
   507	
   508		if (id->driver_data != mid->driver_data)
   509			dev_notice(&client->dev,
   510				   "Device mismatch: Configured %s, detected %s\n",
   511				   id->name, mid->name);
   512	
   513		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
   514		if (config < 0)
   515			return config;
   516	
   517		device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
   518		if (device_config < 0)
   519			return device_config;
   520	
   521		data = devm_kzalloc(&client->dev, sizeof(struct adm1275_data),
   522				    GFP_KERNEL);
   523		if (!data)
   524			return -ENOMEM;
   525	
   526		if (of_property_read_u32(client->dev.of_node,
   527					 "shunt-resistor-micro-ohms", &shunt))
   528			shunt = 1000; /* 1 mOhm if not set via DT */
   529	
   530		if (shunt == 0)
   531			return -EINVAL;
   532	
   533		data->id = mid->driver_data;
   534	
   535		info = &data->info;
   536	
   537		info->pages = 1;
   538		info->format[PSC_VOLTAGE_IN] = direct;
   539		info->format[PSC_VOLTAGE_OUT] = direct;
   540		info->format[PSC_CURRENT_OUT] = direct;
   541		info->format[PSC_POWER] = direct;
   542		info->format[PSC_TEMPERATURE] = direct;
   543		info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
   544				PMBUS_HAVE_SAMPLES;
   545	
   546		info->read_word_data = adm1275_read_word_data;
   547		info->read_byte_data = adm1275_read_byte_data;
   548		info->write_word_data = adm1275_write_word_data;
   549	
   550		switch (data->id) {
   551		case adm1075:
   552			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   553				data->have_oc_fault = true;
   554			else
   555				data->have_uc_fault = true;
   556			data->have_pin_max = true;
   557			data->have_vaux_status = true;
   558	
   559			coefficients = adm1075_coefficients;
   560			vindex = 0;
   561			switch (config & ADM1075_IRANGE_MASK) {
   562			case ADM1075_IRANGE_25:
   563				cindex = 1;
   564				pindex = 3;
   565				break;
   566			case ADM1075_IRANGE_50:
   567				cindex = 2;
   568				pindex = 4;
   569				break;
   570			default:
   571				dev_err(&client->dev, "Invalid input current range");
   572				break;
   573			}
   574	
   575			info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
   576			  | PMBUS_HAVE_STATUS_INPUT;
   577			if (config & ADM1275_VIN_VOUT_SELECT)
   578				info->func[0] |=
   579				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   580			break;
   581		case adm1272:
   582			data->have_vout = true;
   583			data->have_pin_max = true;
   584			data->have_temp_max = true;
   585			data->have_power_sampling = true;
   586	
   587			coefficients = adm1272_coefficients;
   588			vindex = (config & ADM1275_VRANGE) ? 1 : 0;
   589			cindex = (config & ADM1272_IRANGE) ? 3 : 2;
   590			/* pindex depends on the combination of the above */
   591			switch (config & (ADM1275_VRANGE | ADM1272_IRANGE)) {
   592			case 0:
   593			default:
   594				pindex = 4;
   595				break;
   596			case ADM1275_VRANGE:
   597				pindex = 5;
   598				break;
   599			case ADM1272_IRANGE:
   600				pindex = 6;
   601				break;
   602			case ADM1275_VRANGE | ADM1272_IRANGE:
   603				pindex = 7;
   604				break;
   605			}
   606			tindex = 8;
   607	
   608			info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
   609				PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   610	
   611			/* Enable VOUT if not enabled (it is disabled by default) */
   612			if (!(config & ADM1278_VOUT_EN)) {
   613				config |= ADM1278_VOUT_EN;
   614				ret = i2c_smbus_write_byte_data(client,
   615								ADM1275_PMON_CONFIG,
   616								config);
   617				if (ret < 0) {
   618					dev_err(&client->dev,
   619						"Failed to enable VOUT monitoring\n");
   620					return -ENODEV;
   621				}
   622			}
   623	
   624			if (config & ADM1278_TEMP1_EN)
   625				info->func[0] |=
   626					PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
   627			if (config & ADM1278_VIN_EN)
   628				info->func[0] |= PMBUS_HAVE_VIN;
   629			break;
   630		case adm1275:
   631			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   632				data->have_oc_fault = true;
   633			else
   634				data->have_uc_fault = true;
   635			data->have_vout = true;
   636	
   637			coefficients = adm1275_coefficients;
   638			vindex = (config & ADM1275_VRANGE) ? 0 : 1;
   639			cindex = 2;
   640	
   641			if (config & ADM1275_VIN_VOUT_SELECT)
   642				info->func[0] |=
   643				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   644			else
   645				info->func[0] |=
   646				  PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
   647			break;
   648		case adm1276:
   649			if (device_config & ADM1275_IOUT_WARN2_SELECT)
   650				data->have_oc_fault = true;
   651			else
   652				data->have_uc_fault = true;
   653			data->have_vout = true;
   654			data->have_pin_max = true;
   655	
   656			coefficients = adm1276_coefficients;
   657			vindex = (config & ADM1275_VRANGE) ? 0 : 1;
   658			cindex = 2;
   659			pindex = (config & ADM1275_VRANGE) ? 3 : 4;
   660	
   661			info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_PIN
   662			  | PMBUS_HAVE_STATUS_INPUT;
   663			if (config & ADM1275_VIN_VOUT_SELECT)
   664				info->func[0] |=
   665				  PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   666			break;
   667		case adm1278:
   668			data->have_vout = true;
   669			data->have_pin_max = true;
   670			data->have_temp_max = true;
   671			data->have_power_sampling = true;
   672	
   673			coefficients = adm1278_coefficients;
   674			vindex = 0;
   675			cindex = 1;
   676			pindex = 2;
   677			tindex = 3;
   678	
   679			info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
   680				PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
   681				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
   682	
   683			/* Enable VOUT & TEMP1 if not enabled (disabled by default) */
 > 684			if (config & (ADM1278_VOUT_EN | ADM1278_TEMP1_EN) != ADM1278_VOUT_EN | ADM1278_TEMP1_EN) {
   685				config |= ADM1278_VOUT_EN | ADM1278_TEMP1_EN;
   686				ret = i2c_smbus_write_byte_data(client,
   687								ADM1275_PMON_CONFIG,
   688								config);
   689				if (ret < 0) {
   690					dev_err(&client->dev,
   691						"Failed to enable VOUT monitoring\n");
   692					return -ENODEV;
   693				}
   694			}
   695	
   696			if (config & ADM1278_VIN_EN)
   697				info->func[0] |= PMBUS_HAVE_VIN;
   698			break;
   699		case adm1293:
   700		case adm1294:
   701			data->have_iout_min = true;
   702			data->have_pin_min = true;
   703			data->have_pin_max = true;
   704			data->have_mfr_vaux_status = true;
   705			data->have_power_sampling = true;
   706	
   707			coefficients = adm1293_coefficients;
   708	
   709			voindex = 0;
   710			switch (config & ADM1293_VIN_SEL_MASK) {
   711			case ADM1293_VIN_SEL_012:	/* 1.2V */
   712				vindex = 0;
   713				break;
   714			case ADM1293_VIN_SEL_074:	/* 7.4V */
   715				vindex = 1;
   716				break;
   717			case ADM1293_VIN_SEL_210:	/* 21V */
   718				vindex = 2;
   719				break;
   720			default:			/* disabled */
   721				break;
   722			}
   723	
   724			switch (config & ADM1293_IRANGE_MASK) {
   725			case ADM1293_IRANGE_25:
   726				cindex = 3;
   727				break;
   728			case ADM1293_IRANGE_50:
   729				cindex = 4;
   730				break;
   731			case ADM1293_IRANGE_100:
   732				cindex = 5;
   733				break;
   734			case ADM1293_IRANGE_200:
   735				cindex = 6;
   736				break;
   737			}
   738	
   739			if (vindex >= 0)
   740				pindex = 7 + vindex * 4 + (cindex - 3);
   741	
   742			if (config & ADM1293_VAUX_EN)
   743				info->func[0] |=
   744					PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
   745	
   746			info->func[0] |= PMBUS_HAVE_PIN |
   747				PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
   748	
   749			break;
   750		default:
   751			dev_err(&client->dev, "Unsupported device\n");
   752			return -ENODEV;
   753		}
   754	
   755		if (voindex < 0)
   756			voindex = vindex;
   757		if (vindex >= 0) {
   758			info->m[PSC_VOLTAGE_IN] = coefficients[vindex].m;
   759			info->b[PSC_VOLTAGE_IN] = coefficients[vindex].b;
   760			info->R[PSC_VOLTAGE_IN] = coefficients[vindex].R;
   761		}
   762		if (voindex >= 0) {
   763			info->m[PSC_VOLTAGE_OUT] = coefficients[voindex].m;
   764			info->b[PSC_VOLTAGE_OUT] = coefficients[voindex].b;
   765			info->R[PSC_VOLTAGE_OUT] = coefficients[voindex].R;
   766		}
   767		if (cindex >= 0) {
   768			/* Scale current with sense resistor value */
   769			info->m[PSC_CURRENT_OUT] =
   770				coefficients[cindex].m * shunt / 1000;
   771			info->b[PSC_CURRENT_OUT] = coefficients[cindex].b;
   772			info->R[PSC_CURRENT_OUT] = coefficients[cindex].R;
   773		}
   774		if (pindex >= 0) {
   775			info->m[PSC_POWER] =
   776				coefficients[pindex].m * shunt / 1000;
   777			info->b[PSC_POWER] = coefficients[pindex].b;
   778			info->R[PSC_POWER] = coefficients[pindex].R;
   779		}
   780		if (tindex >= 0) {
   781			info->m[PSC_TEMPERATURE] = coefficients[tindex].m;
   782			info->b[PSC_TEMPERATURE] = coefficients[tindex].b;
   783			info->R[PSC_TEMPERATURE] = coefficients[tindex].R;
   784		}
   785	
   786		return pmbus_do_probe(client, id, info);
   787	}
   788	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26324 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20200610/f4068df7/attachment-0001.gz>
