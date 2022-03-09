From: Cédric Le Goater <clg@kaod.org>
Date: Wed, 9 Mar 2022 16:59:20 +0100
Subject: [PATCH] ARM: soc: aspeed: Add secure boot controller support
In-Reply-To: <92c2301f-5759-c13c-84f6-52ec69af7de6@kaod.org>
References: <20220304030336.1017197-1-joel@jms.id.au>
 <92c2301f-5759-c13c-84f6-52ec69af7de6@kaod.org>
Message-ID: <618a4361-ca04-81e4-99af-f7d9a3a0b7d6@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ ... ]

>> +??? sbe.abr_image = !!(security_status & ABR_IMAGE_SOURCE);
>> +??? sbe.low_security_key = !!(security_status & LOW_SEC_KEY);
>> +??? sbe.otp_protected = !!(security_status & OTP_PROTECTED);
>> +??? sbe.secure_boot = !!(security_status & SECURE_BOOT);
>> +??? /* Invert the bit, as 1 is boot from SPI/eMMC */
>> +??? sbe.uart_boot =? !(security_status & UART_BOOT);
>> +
>> +??? debugfs_root = debugfs_create_dir("aspeed", NULL);
> 
> may be use 'arch_debugfs_dir' or is that the same ? and test the returned
> value as it can fail.

Also, CONFIG_DEBUG_FS is not always selected.

Thanks,

C.
