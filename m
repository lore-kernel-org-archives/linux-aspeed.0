From: kbuild test robot <lkp@intel.com>
Date: Mon, 2 Sep 2019 15:49:58 +0800
Subject: [PATCH 3/3] pmbus: ibm-cffps: Add support for version 2 of the PSU
In-Reply-To: <1567181385-22129-4-git-send-email-eajames@linux.ibm.com>
References: <1567181385-22129-4-git-send-email-eajames@linux.ibm.com>
Message-ID: <201909021511.JcXZhb33%lkp@intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Eddie,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc6 next-20190830]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Eddie-James/pmbus-ibm-cffps-Add-support-for-version-2-of-PSU/20190901-151755
config: x86_64-randconfig-s0-09021304 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hwmon/pmbus/ibm-cffps.c: In function 'ibm_cffps_probe':
>> drivers/hwmon/pmbus/ibm-cffps.c:404:8: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      vs = (int)md;
           ^

vim +404 drivers/hwmon/pmbus/ibm-cffps.c

   393	
   394	static int ibm_cffps_probe(struct i2c_client *client,
   395				   const struct i2c_device_id *id)
   396	{
   397		int i, rc, vs;
   398		struct dentry *debugfs;
   399		struct dentry *ibm_cffps_dir;
   400		struct ibm_cffps *psu;
   401		const void *md = of_device_get_match_data(&client->dev);
   402	
   403		if (md)
 > 404			vs = (int)md;
   405		else if (id)
   406			vs = (int)id->driver_data;
   407		else
   408			vs = 1;
   409	
   410		client->dev.platform_data = &ibm_cffps_pdata;
   411		rc = pmbus_do_probe(client, id, &ibm_cffps_info[vs - 1]);
   412		if (rc)
   413			return rc;
   414	
   415		/*
   416		 * Don't fail the probe if there isn't enough memory for leds and
   417		 * debugfs.
   418		 */
   419		psu = devm_kzalloc(&client->dev, sizeof(*psu), GFP_KERNEL);
   420		if (!psu)
   421			return 0;
   422	
   423		psu->version = vs;
   424		psu->client = client;
   425		mutex_init(&psu->input_history.update_lock);
   426		psu->input_history.last_update = jiffies - HZ;
   427	
   428		ibm_cffps_create_led_class(psu);
   429	
   430		/* Don't fail the probe if we can't create debugfs */
   431		debugfs = pmbus_get_debugfs_dir(client);
   432		if (!debugfs)
   433			return 0;
   434	
   435		ibm_cffps_dir = debugfs_create_dir(client->name, debugfs);
   436		if (!ibm_cffps_dir)
   437			return 0;
   438	
   439		for (i = 0; i < CFFPS_DEBUGFS_NUM_ENTRIES; ++i)
   440			psu->debugfs_entries[i] = i;
   441	
   442		debugfs_create_file("input_history", 0444, ibm_cffps_dir,
   443				    &psu->debugfs_entries[CFFPS_DEBUGFS_INPUT_HISTORY],
   444				    &ibm_cffps_fops);
   445		debugfs_create_file("fru", 0444, ibm_cffps_dir,
   446				    &psu->debugfs_entries[CFFPS_DEBUGFS_FRU],
   447				    &ibm_cffps_fops);
   448		debugfs_create_file("part_number", 0444, ibm_cffps_dir,
   449				    &psu->debugfs_entries[CFFPS_DEBUGFS_PN],
   450				    &ibm_cffps_fops);
   451		debugfs_create_file("serial_number", 0444, ibm_cffps_dir,
   452				    &psu->debugfs_entries[CFFPS_DEBUGFS_SN],
   453				    &ibm_cffps_fops);
   454		debugfs_create_file("ccin", 0444, ibm_cffps_dir,
   455				    &psu->debugfs_entries[CFFPS_DEBUGFS_CCIN],
   456				    &ibm_cffps_fops);
   457		debugfs_create_file("fw_version", 0444, ibm_cffps_dir,
   458				    &psu->debugfs_entries[CFFPS_DEBUGFS_FW],
   459				    &ibm_cffps_fops);
   460	
   461		return 0;
   462	}
   463	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30810 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20190902/23d9fa8f/attachment-0001.gz>
