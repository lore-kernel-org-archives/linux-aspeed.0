Return-Path: <linux-aspeed+bounces-2831-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C49ECCFA18
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 22:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3DgX6MF6z30T8;
	Sat,  8 Nov 2025 09:46:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762555576;
	cv=pass; b=W6fUSSlryBxsfizVWrlqMlD4ixIkqKVzA+z33rPdcxBGC0RM273T7JPa8YtiZX2+ZQqG5ToEdqSMEN6+Ns/wGCtb+CAwnWP7WS+Ed0eJ5FygQQxpvIE0H4xNUqe/phSEbyJ9oUFMsCrlDbBZlmLZJrc3/S6siZgdL5smqlKXIkTXaAHttUTbynt9LdGsDKdjQgENVtaXpybSmT9Ib1gsKTfwhhBK59ML2YKBI7vlYA8LwOoCUvfDN0m40Soh11P/vMoCq5bZgIsT0XOWdiRdFJ/VCe2alaaa2ZeOw80K9/gifBwyTv/CrgfSCK325rA1k5iFrFejvRzO6RhrXSOw1g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762555576; c=relaxed/relaxed;
	bh=EAZ4SbvoSTSUdZpfiuvITsft0eAQLLrdsklp0B59c4Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RVMyVhERqJkd3eYug9fqehXsIAZ4wgM7+9mD0rAzDgL3B7b3202Wcq0wXQy9McYHVY/6uVdTqag7xG6tLPf++6xIt/KMKdEc+qjAaIWXwPCslvS3Y2IUh3BelSWwz/epj+q2LmyTh4OQNgLtxYKjfymMK9T6XKMHhto6w/CM2vruuK25Sc0aPuYJRh87BQniTfIWLRSAApeem+UOUjWM3D8LeTXNlxIVDfodtu27dxPlQDvl4SBwhLQmo/4a7u+2tb610hM4TW6GALXSGekOkLufRK7II0USTIjXKRBXaVy/XkVYj65pKlfoqAwrlkvFUH11gUKrEDW8jPMJ5zwr8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bmNJXtbx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bmNJXtbx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3DgX2WCjz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Sat,  8 Nov 2025 09:46:16 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/In8XQ3aMTTsdr/3kYs/EMGN0w7NZfN+eVArPjiPQLha4ojz2N6jYFsdjU8C8x5GL+ldIRjAsw3FR/lwU0tqWxfSIN63RFqUJG4oiZjy9fYo1CcPjMNnnIoWfD/C/pUJwJNMpTWpGTE6fHZcx1yt7DhRZgBn2Ue8kcl5rffRmqv2EZWfpxxmu2/1J4maDi6g5ItM3vTp4CyoCkxpn1knpk3D4JzSW4nL1q/MsyKqJi/tiAHUa+/+c51jCfqIKeziLeNT5eN9uOgROUehKM+BuIUMK8KoxzOFrvZ7mhNsthDo0RguT4JT5wVxTQlWcdhYH8n0CFAmX+budF2z3VghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAZ4SbvoSTSUdZpfiuvITsft0eAQLLrdsklp0B59c4Y=;
 b=jWd3c6qlxStcA0z6BE/IeoFdqFwzk9CK1T4ShnpoS/Et8pLKYmA2nu/O0+oJ/M9U9nVhaNlGEIjHt5rvOqaYSnp6ggcyjow2MTPaxlzVo7J5GlH2r+DSrEEjF/wrgsPFGEnOVPYz7EGX+CkEm9e3cdrMHaUm1wyWKu/zzltgbOr2K1KA5xFwBF1rAlbLdpQaRD3/YA4Yy+EFfGeH+TSs+38fDgegTelcWhHvJeLsAtpIZXzOh6C214p7OJGq/0slqmlQIuc8bfXLjhpPN4YqMImmj0JTbhrODqKZAkKEhhEQm7sk0RSb4Xt3HRmkficVp09U2vBe1r+hvwXBBd23dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAZ4SbvoSTSUdZpfiuvITsft0eAQLLrdsklp0B59c4Y=;
 b=bmNJXtbxKigDtpyNGW1s7nHEq889r24EVUFd/z0e/Xp3XH0A8YIyCKRSgTAyjuBT3p6ucKd4nybM4kkEutV2ZFZkx8GpyavMjTO4impfeJZdrhu5GYE1Ja+MF5i1LgBH7XkoqC2olWYDcVgbcbdSI8zcL5Rx7CLU5OupiWc9AvVNpQR6PbXvcpHV7BDAtz6hp+VMsz8aPtpSbDmqqqRfSEdK9RvKUMzf+CEuV6fECnzpU8RQB0pB2O2yQG8q6iDaplMVNLeeGiGNuIJ18dsTHQQeMHKIpFNNzm1sATckiqxW46dqEGn52+QNbXA2B+FzUGeK1YnOBdLtdJLjvI2kIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SJ0PR12MB6806.namprd12.prod.outlook.com
 (2603:10b6:a03:478::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 22:45:44 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 22:45:44 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Fri, 07 Nov 2025 14:45:37 -0800
Subject: [PATCH v2 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-msx1_devicetree-v2-2-6e36eb878db2@nvidia.com>
References: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
In-Reply-To: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762555539; l=5870;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=tuITM0vDGMpc5FE7fn3/K+mrEUwOuMW5UTcrQpypRwU=;
 b=X017JzTK35B5QFQR1dxT9OBgvsFL+Gw4hyo2Cia+1EtxWWnZi90yD6e6WauuzhARlnKSJvOOn
 YhqYuqzZEcmDWu4jk9RYS9GLad68rY3hjWfYEzncNPEIOV/wkgmgMrL
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 250b9bd0-a8e4-40bd-6d2b-08de1e4f6306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkw5bmlFUFNhTytWb2w1T05laG5ZbTExOUMyTzR2a3l5cTc3VFNEYzRGY3BJ?=
 =?utf-8?B?cHJGU0NOb3N0MHBaaFBjN05aOHRlcjV3dExpamRsS0VvVzk3SGMvY0Q5WjhL?=
 =?utf-8?B?RkhJVk1vNXg2RE1FK1dTdm9mcEVGdGZ3N0hpaVJ6M3dET1VUNndCK09iMUsr?=
 =?utf-8?B?QVhBRnlsbFhxaStCeXQ5WWJoQnpHTlZ4enVJa3BIZGFaRW9HN1NhcVZSVCtJ?=
 =?utf-8?B?a1dMc3lCUllDNHAyN2w1MUc4ZnZ0MllWbVVQUmhwUmdVb09EQ2prM1F3ZFlF?=
 =?utf-8?B?SDBCaFJVdnY5NHpVZ0dVbmw4bmQ5UjlkNldoRkErWDBlR0NjcjNXOUR2YWEx?=
 =?utf-8?B?SWxTQUp1YkJFN2xpMnpscUY2QkZ3dUF6R2hKYzBHN29YKzI3RXNtSXM1dmxV?=
 =?utf-8?B?cGdnODI5aVM4enJUTHQxRjRzc3FvUHhHMVUvWUhlYWxYYWp1Q05xdkNTaU9F?=
 =?utf-8?B?cXZFR2JXQXZ4Y1dXOU9yUFJvaWRRZTVSbUVlNnBpYm1NTjY0aSszQTdwSXhO?=
 =?utf-8?B?ek1CODVWWjBEM2xPQURVOStEQkt0WE9RcjZhTHpvUzk4UDE4QWtiWFFFaGFu?=
 =?utf-8?B?R2dzR1R0NjErT2NHTklyemUyZWZzajhEOW5JdFE2THovUUtsc1BhVTVNci93?=
 =?utf-8?B?SXRMNys3L0lJRjloUkxFOEc5R2Jlc2hjNWd5UGZSNGdWYlpsY3RoYXNhVlEr?=
 =?utf-8?B?c3NyeTRJNEgySVVqbVR0UXBhNWViTmg3bEI1Z05QNisvalg3L2NRU3VFV3V2?=
 =?utf-8?B?cFFmRUQ5T2FnaklNUlhrRzhMM3VOZlpmVkNtcFFDNG5TVkVkcjhHV3ptTmZv?=
 =?utf-8?B?bHRqMkowNWRjNjZETGtjSlJ4UWphelZUeGRtVGdWR3JuZFdBeWxUK2R6QWxt?=
 =?utf-8?B?MlNRdDBndkdLOE1kTTRTeTdXVlFQMlhBTDQ5dDgxU3lYdVhJTzJ5c3ozMXBx?=
 =?utf-8?B?MjVHa1VVQ2hvMExNTEg1dE1ra3liakRUY1VNQkFkZUYzbHRSMUUyT29raWxv?=
 =?utf-8?B?V0lpNXBwNWpUWlZ0WmRsNDhUbWZ5b0E0STZUaGEzWU9Ca0ROK0d1MlQ3dlVZ?=
 =?utf-8?B?YWdQWDlZcFYyZU9FdENrdVdRVlRwVkJwQTE0aUY0KzlWZDBZQkI2TStoL3o3?=
 =?utf-8?B?VWVjSVBYZG5hMXkvWTVBZ1pSL3EveWFtc0w0WjNZbEV0T0dSclYwaS9XRDk2?=
 =?utf-8?B?VFpBdE1LcmJuWUpWTG4vTWdqdmErWEpyMjZRM1BkcGJUQUVwblZSRzZPRWh2?=
 =?utf-8?B?a0tSRHY4RGtlSjNZMEJreUcwSzhYZ1MzZis3N3NqRC9CRUY2Y3k4SnpkUW1X?=
 =?utf-8?B?RVZTRlREUkJHT2hRSXJHZzUxQTNWZUtCa1g5MFdpT0N5WnlBc3dwczFCNXZB?=
 =?utf-8?B?TnM0dkVpQ1I1TjU3Q0FTWHh4dXRtUGRmcnErenZBK3EvYW5sSU41dTdpRG43?=
 =?utf-8?B?SWUwcm14ZlFOZjk1VXYyVnltcmk5NDBPR3pXNGdSVVRzdTRnaEx1RytsOWha?=
 =?utf-8?B?d1czSElUYmFGNVlsWFNKK09tWGFCMXQ1cEVFV0xiMm9PbzI2c1NSUXk2bW5I?=
 =?utf-8?B?SS9xUzdnUDlXSnNYZSttancvNVBxMFU4M0I0VW01VmZNMnRJa042SVZVNlpu?=
 =?utf-8?B?eTBma1QyQVdaOUQxaHpYVTlBdzJ1VUZtNjByNmNydjk1ekNtMFVvTU1uc05R?=
 =?utf-8?B?eU5lZGJhVTIzWG5Tc3d4NVJyRytkbFZ6TUpVK2lpN2NWRktSekYwYUQ2Z0du?=
 =?utf-8?B?MUJaYmx0dElKTGwwejU0VlhqeTF0L0pkUHprSW5jS0FMcVdyZGdFRnBnNVBZ?=
 =?utf-8?B?SXFNVnV6U1pGNEdNVklFVHJjQnNQRmw2UG9wSFhueWZJNGJibWhnb2FaTCtB?=
 =?utf-8?B?RWRIa1gyRHhidm4vNzdOL3lpQ2I2USs3U2pzdE1YWXAydTNmOTBvaGpSaFYx?=
 =?utf-8?Q?2vNxVykvQkYBM48oz4dxQjZN7OwXGN7G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElMTThGVWZ5US9xTS9vVS9VTzdkanlKYkJDdlZmTG44RjRMaFFESlpPamMr?=
 =?utf-8?B?cTZjNFMxSU95Zit4QXRwT1pHaS84dnYwMnB3eEFnU1dEWnlKL00rMFE1L1RT?=
 =?utf-8?B?ZXoxMWNrSDhwY3RTSy80RDg4aDdJTEhDcitFKzNWcGJDcUx1emNWOVNGOC92?=
 =?utf-8?B?WWI5MFNaRnI4L25qZFMwT25OZWlJSjgzYTliZzE2aUp1bWRZZ3VndjAvZHdp?=
 =?utf-8?B?Z1V6QjhrYnAyVUlybmtEb2tlQ3JzRHo0UG9kZnFGWFRzY1dsZzd2S05pcGFD?=
 =?utf-8?B?YnNsdFJJcDJsbHJUK21OWWJQQ0FnVGxkZW55M1g4VTVlZzdoVXBPWTBBSGJ3?=
 =?utf-8?B?ek1NV3hkZk55TmpJdEF5VnE0Ym16Tm44NHM1dTZGVEdsWWwxekkvSkZNQUdJ?=
 =?utf-8?B?amRZY1VndWJJR1FtRzJldy9QekJEckh0enJaMVFNemxXY1IwcEpGdkVaWmRU?=
 =?utf-8?B?dFo2K2JwRmVXbTFvSVhuWTdCdFg5THJDTnBLUmxaWENaeWRtck00R3I1SGhv?=
 =?utf-8?B?QXJ3SitVRWxyNktPT3JXakJkOUovNkFWSVZjTllUZVFidGoyWis2eW1xcEsx?=
 =?utf-8?B?YnhDYXNYWTFxRHhoaDEwY2FoaEpNR2l4SVl6eENYT1VuWmJkSGJDcXNkTzdk?=
 =?utf-8?B?V0JrSEVtdWhib2F6Y2FIWk5kRy9PTjR6dGZ4U1lhbkV2dXlZZTZqeHBIWGJT?=
 =?utf-8?B?eWUzS3FMRzBpR1hhSEFGTmZ0SmxFVTlVUmFLMEpIaTJGd0c0RXBzSVhoMGtN?=
 =?utf-8?B?aU1BcjFpSGtqVXpVNVROLzN0UGVkMGxvWUk5MmtRYm8wVEpOK2trQUVkNzgy?=
 =?utf-8?B?SUt0TUp0YklOeGpIbS9RcE0xcW5NeHB3R2Z2Y3BQSDF2TWVqbFpPRC83enpZ?=
 =?utf-8?B?aUtCb0dlS29CbkNFR1Rody9nNWx6alhsVVArK1kyYzFLYjBubmkwL1pRcEZL?=
 =?utf-8?B?b0xZSElDY01nMnZzRUZDS3ZlUjVYY013OVdWdmd6Y3JhQ04yMkRlKy82Wk51?=
 =?utf-8?B?Uldab01RdWdKK2xBVTBzYTdjM0JsTElSNm5XbzVKTEZKWWIySENwVXdKeEtn?=
 =?utf-8?B?RmV4S3JiYWpEQ1YxVXp4MzhjRDlPOXppQzVGTjNiQTBBTEtuT1gwZFR5VGNj?=
 =?utf-8?B?cDBMdjV4UG4vYjN1dDREOE92UC9uYnZURm9wd1JzOC9YMm5VV1JKNUxKSHFX?=
 =?utf-8?B?MnlIZW11clhpWXh3WDBVN0VLbkRtNmY5RzIwa3RiTmhwUmNqNzhFdW81TkdW?=
 =?utf-8?B?blVkb0lWQW1FTFVHZWFkcTc4YVVZSUlsbyt1RG1DK3NGODh1US9HWHg5Y1dG?=
 =?utf-8?B?V3RHRnlMdUxEUEdLWHdiMU5aQ0UrNkFmR3NaNThOdWhxa1dObnBXa3VGVWRp?=
 =?utf-8?B?dHpPYWsxUmE0VEZYZVBEV0pMQ2g1V1hwOTdZSTgrV1crYmpadmwxNlI2SlF2?=
 =?utf-8?B?Q3ZiRUZNNUFpT3ZSQk81aUdEUUVMNzNMRzFjWjVHSFNrb1VCQWVNMTErNW1B?=
 =?utf-8?B?MThGcy9LUTNkRkE5Y1NEVUxxb2ljNjFpZXZtdk5EN2JaZ1ZhOWFjMERuU0dX?=
 =?utf-8?B?T1h6ZEplSlIySWsxK2pxWHhyNXRCMytuN1dvMGErcldkT0RtQVFvVk4wT2lY?=
 =?utf-8?B?MW5UalliZXc0MVFtL3AvaGdLbzNSaitvSVpoNWM2MU5TVkRRN3JCZk5LZmw5?=
 =?utf-8?B?a3B1cnhZUVk1VXEvRW8vQW1QSTQ3VDhsRlB3YUR6aXZPME10OWpSTm5DQkRy?=
 =?utf-8?B?TVNMY2w2M09rUFJOZVdtR1RaL0dSM1dxdHRIOFVPUU9wejhFN3RqbStYWnYz?=
 =?utf-8?B?N2VaWHV6cEZYUU4xYldOZEVwRzdHdGljZnA4YzJMZkdpb2FDL0d5R1N4Q3BO?=
 =?utf-8?B?bnlhOFB1L0Z2RWRtZDluUFkvRGEzUlJTbTBJZTQrMWZZMUc0VDhTM3Y0UmJu?=
 =?utf-8?B?YU93MC93WW5yYWxveGhKYVY2UVp1S3B6cHZiMFVXMGZkdUpQNzFGUWFXTURl?=
 =?utf-8?B?dVBCM2FWKzJvbzYwQjJYQU1Qa1REejNqZHJob2lDd09GRFJCSUw1VkxET09T?=
 =?utf-8?B?VGhXR1ptKzNXaHBLTURnTk80N08rVmplbE4vdHhxaHZsN1ZwajVLTzRqZHk1?=
 =?utf-8?Q?U92k/qGgf3gMoYFYdR9zqoEuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b9bd0-a8e4-40bd-6d2b-08de1e4f6306
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:45:44.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAVEsfkMJrFsCe/nfBaIVUeLRWGizYJWrdSK++xABpEcYbjgVRZZynoiaxsCdeULZgsdBTxyV+f0eoxUwihiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

Adds a dts for the nvidia mgx pcie switchboard reference
platformi hpm. This is a dual socket granite rapids based platform.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 254 +++++++++++++++++++++
 2 files changed, 255 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b7076545e6babb2f25f302b5d70b71d8a19..c3ce0d218b53f2b4c37061cace483f5f2c6d3bf1 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -56,6 +56,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-msx4-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
new file mode 100644
index 0000000000000000000000000000000000000000..383e53656a3f3dbb0f394b5f8dddc58405cd8da2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "AST2600 MSX4 Kernel";
+	compatible = "nvidia,msx4-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "uart5:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			reusable;
+		};
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		label = "bmc";
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		status = "okay";
+		#include "openbmc-flash-layout-128.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0-A7*/	"","","","","","","","",
+	/*B0-B7*/	"ASSERT_BMC_READY","","","","","","","",
+	/*C0-C7*/	"MON_PWR_GOOD","","","","","","","FP_ID_LED_N",
+	/*D0-D7*/	"","","","","","","","",
+	/*E0-E7*/	"","","","","","","","",
+	/*F0-F7*/	"","","","","","","","",
+	/*G0-G7*/	"","","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N",
+			"","","","",
+	/*H0-H7*/	"","","","","","","","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"MON_PWR_BTN_L","ASSERT_PWR_BTN_L","MON_RST_BTN_L",
+			"ASSERT_RST_BTN_L","","ASSERT_NMI_BTN_L","","",
+	/*Q0-Q7*/	"","","MEMORY_HOT_0","MEMORY_HOT_1","","","","",
+	/*R0-R7*/	"ID_BTN","","","","","VBAT_GPIO","","",
+	/*S0-S7*/	"","","RST_PCA_MUX","","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","","","","","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","BMC_INIT_DONE","";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "atmel,24c256";
+		reg = <0x51>;
+		pagesize = <64>;
+		label = "sku";
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&kcs1 {
+	aspeed,lpc-io-reg = <0xca0>;
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	status = "okay";
+};
+
+&lpc_reset {
+	status = "okay";
+};
+
+&mac0 {
+	// bootloader takes care of proper mac delays for now.
+	// set the phy mode to rgmii, and if/when the driver is
+	// fixed, we can make the switchover to rgmii-id
+	// and have the phy handle the delays.
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy3>;
+	status = "okay";
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <2>;
+	};
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <80>;
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};

-- 
2.34.1


