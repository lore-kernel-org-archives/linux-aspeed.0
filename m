Return-Path: <linux-aspeed+bounces-2387-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7FBCAC5B8
	for <linux-aspeed@archiver.kernel.org>; Fri,  3 Oct 2025 01:51:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cdBTX2wXXz3cp1;
	Fri,  3 Oct 2025 11:51:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c405::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759456272;
	cv=pass; b=GqvCPOXnxQcaEIEswZwkSnrb0eOsv5tkI4xw2eeIQgwoLLWAT/Bdf8uoqN+Jgu8KZ3ufK+Yfi5aNwox95I/Jk0Yr7k9vY/aNjqEXCvSiL4b8Dxzf8Me33jLkphuMvNxivQeZwKLzlbYMfZtKvLa7x96h4xok9GUTPJM0ypCIqSYj8kghKwehzeyb4WLVLb1BVX+5Cx4ccOJxeURvS3d8K5poGqABYxwzk8zpD9HhGafTCnbE+yDq1n16tRXVkJCtwCgAlq4t7TQVbMSRnLxRanwxRKtBy1jtVs2UH5g4Kg7Q6glS1CWEG05/yqIOk0p+nJps6wbpNFZyyItHag8ZJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759456272; c=relaxed/relaxed;
	bh=0eUIU8QddP7U3dbI8j8sqZPz2v0ox91us2uZDLfwpw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LibKvPg6CCHlsH3LFNdreIDu9qg8dxaCC9cTq8qWWGhG1+r5jxK4GJ4eihzDdq/37jeuGM6dGfQcT2jrMXpdOl7lfXB3W4jmU+2LczRrtdQyYT5zC6+uWZWX1y6HEPKpcfTJ9zIsz8CbHu08331kz7o2NjKjCY/dJMFNwCA615HY5FCU6t8Kq5Nkdb7q4a8ejf7kA/Z5G95xT6d6xGIXXQk37uRVyPMwWnhuTIGWQuFcdDB+oo8NzSMPtgvuy0qVS1/34xh6L/w4qqJB/YI2BToCZN7/IVpdxjg8D2KPnXtQICi13VKkL63HAuDvxRLdCg+2HxXnnwgiV9WZn9D53A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ftbYU2te; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ftbYU2te;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c405::7; helo=tydpr03cu002.outbound.protection.outlook.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c405::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cdBTV2VtVz3cnv
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 11:51:10 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOedosVROtDZbdFISrTiOuXsH4lkxDb+hS3lKT0yReyAA67i6B/IgqUSphtDMIjbiR7TomQCKfxRHHO44Si02ltDWIlYhY0A4O6bkYrg7dsEqsPXtES/C6MzcZ8MUerM9rY94vfj9zrN6magW9SmkKVkd5Rr3stCRtDfynCDbYAIEOSWAb8USeQpZsLxiDTkBGcIhGvRQpJ4CvpaBtQxApMiJJiaYAh7b/ZFHlDGvpE47YIzkR1MpNZ2ZBQiSq6P0/siFH8PDyvfyfhY0M6QuOzcPriknm0EF/Wie2OZWxRc9u881yWGhvVRGozhBGimOTWt8LZl1nzf0wLuKl/EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eUIU8QddP7U3dbI8j8sqZPz2v0ox91us2uZDLfwpw4=;
 b=siAKq8qmJfX9EpogUggtTC2Dbw1Mc8hSaJbNApPbm4y2V5eRh+VWm3xPX5mXOINHE15hHqithl9pzUPCdEPWl3pFJOLEKRRZI6MaYFt/jlzSUgC/Zvg1+9nYl+Bofsho20JqzTFcAgs8xSOICnH3zxTZWDJFrmrvZJD3Lt0bS05sjolzSx3gyHpD22Nnem+vBV5SJcdRyQ3tguRU8yye52mkk4NERVIWQL7YskeEAl4+99I3NtL4YT3DpOEV7hWroSmLRJkznqu78ID/yYMBNwrXXszjKT3Ht2nroVxNYiO9OTA2PYk4WW/9pEFgdrFzPbYZ4M5MbxgO3GllGrqSmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eUIU8QddP7U3dbI8j8sqZPz2v0ox91us2uZDLfwpw4=;
 b=ftbYU2teXVf5H4k8nzAvUoiFJgsIAuOVUk1iqk+LqgLJvuzdh9oJuuTkl2Qe96vByONSA5jw1fq1ZahEME5XT4N1n1flWbXVdjgwgvwNAyBnvR0vin0uFdw17Eq2esiGy3fPFbseia3yDOxvT2bJueO01jESokKd87MfWTXB0el0ksm6TldmTs1u2k5E9uIoHARCOqRq/F9Hb4Cx8H4y48IirlJ+mNLkz27zIV97+hFz+bTM/tldsiSjuj7GwTVbAMuGpNltvys0i93DJLoutnqg2N1UvdluALXq82tPbawJcrjhgJHlMOa4Iu2r4NoU3iLkH8NkEPODksPT88f+jQ==
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com (2603:1096:400:45f::6)
 by TYZPR06MB6638.apcprd06.prod.outlook.com (2603:1096:400:463::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 01:50:46 +0000
Received: from TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b]) by TYZPR06MB6568.apcprd06.prod.outlook.com
 ([fe80::72b8:dce5:355b:e84b%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 01:50:46 +0000
From: Jammy Huang <jammy_huang@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org"
	<sboyd@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Thread-Topic: [PATCH v1] dt-bindings: clock: Add AST2500/AST2600 VIDEO reset
 definition
Thread-Index: AQHcM8zNOOsbpV3YnE+OmVgympoxjrSvp/gA
Date: Fri, 3 Oct 2025 01:50:46 +0000
Message-ID:
 <TYZPR06MB65687E6795F9C899B3F067CEF1E4A@TYZPR06MB6568.apcprd06.prod.outlook.com>
References: <20251002095651.2211900-1-jammy_huang@aspeedtech.com>
 <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
In-Reply-To: <20251002-accuracy-gloomily-a3e46d5a3f02@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6568:EE_|TYZPR06MB6638:EE_
x-ms-office365-filtering-correlation-id: 13448bca-8ce3-4ed5-a089-08de021f4534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NodmLYu9gah0X55bjM4jn7UW6fscvp0Xir9To8SUIFvZ34SFZ3GajCYyfL9f?=
 =?us-ascii?Q?MMfP7RLSfYmjqfuiQBBWiYlFFkP2TZLqmly/gX4ILc9cbnvOEG0YgpnHMJVq?=
 =?us-ascii?Q?Dj9QJN7CGC+rdRpa4vkwDjy0/fo0+Xs7pnnMH7L0LD7dv1rJvc0Rsr8i2gj3?=
 =?us-ascii?Q?zQ9t2jor0q46yARXhpx79/mUGBXS2uctfCzEZC2Qyw9ulsP1YMRS7FgUSpkc?=
 =?us-ascii?Q?YSs7orkj1WXVu1iCEFVvYC/SFX7dhaKK4c7ERoxCqzU9dZXg5Mk17zthW9Cg?=
 =?us-ascii?Q?BSEk920O1JGmCeSzSiAkYOmGOkjtaCRGzQvDPDmYRhC6qbW0uGdHwZFgiksl?=
 =?us-ascii?Q?daHraI8mylg4pCMMDP1W7x+EMVUVFkvh8kwgPfpP+7UlcLsHmHR9kB4XwZl/?=
 =?us-ascii?Q?qpMCpizIq4/1cut7mHUqsyi8hVVeBmE/pAqajyi8OVp2cC73JBayrONU4KSH?=
 =?us-ascii?Q?KShRHC4MLlFLMzb4X7HZrb71u0V7VH1+kMIIhHxZIsvsXPhfKo5qdWhER+1x?=
 =?us-ascii?Q?J5eu9+qd5OMEF/bbxCQVv6r1QgM12SQOEnwum7dLWCxWiFZ+b25ESF9fDmKs?=
 =?us-ascii?Q?saUsDcpESTwdvC2enyiMXA1K3vC1CO29SY6T8ki3UTtTbm1102/g63rJ4sN1?=
 =?us-ascii?Q?+J4k89HO0gezrrThGH+tsvgvLckLJjESvHo7LfmoU0t6/4zyfMe7ginZK8Iv?=
 =?us-ascii?Q?spRPCoyyOIUVlPl/5FrItxOXifdkVjkLivpH9OYA3dj6/2rBScGhT6HYympI?=
 =?us-ascii?Q?8ssBRQ9LOYVbYjcOxgToASlC3ei1xydxZLLcyYLR6tfv/vIoEvpQmi42nkJm?=
 =?us-ascii?Q?MkyFLTR2W9C/Yobifqs46blan/JvXPkZXXSIV1mictTgRnMbIxaobmnu01hA?=
 =?us-ascii?Q?tr/7vm/ggBeCnXJKiOZJ+bb/SPcYzS3dH+MoQvvKouCZAoKXAgxzh0sR/AiE?=
 =?us-ascii?Q?2ZltrLwIR+P+1XTCeFif7fbD/XFkK5oyHPUwChpS/IJ4zoH6gm945X1AAyFL?=
 =?us-ascii?Q?TgoGEsdszI0Wk64Vpvwza10wV86FlctyVz78WtjJIVy7Px+fzm7hog+UpCzG?=
 =?us-ascii?Q?1rYi1TbAM/ISt8iY+NUeloD1P2CE2JC6WAwSlsD3WBsjsqBxxKldMZR5gU2R?=
 =?us-ascii?Q?Fxra7P3ai+CbcnZe/Cy+eJWQ9vapZBiq35h+76eLKW0vgB896Un8hKBRZve6?=
 =?us-ascii?Q?5OEFCKR6vFD5b/OkBmFKQ2AOfzG1+F7lzsnP6mexGybK1vOrIme5b8kUDGJx?=
 =?us-ascii?Q?SXkHh6dNYtqEHdy0MAvMKeZpKtYB900RL6GO6TKcLz9osUzY4UETlUKNERWQ?=
 =?us-ascii?Q?QkkrahGKakunP4nBOeMxCd+MmsSSk7uKSpx44Ea4RnHcRTSLSvsnOaGtT3ST?=
 =?us-ascii?Q?bfVmfqtEmTl5VihSBb9UlHAhQeKYee8mv6b6AFmL2qd1vxnE/9xwkBliSFU3?=
 =?us-ascii?Q?i0KIVAnawJuniCQZq/60ShFt+qSQeJlUqdgDM3nsQTEx/9PTzxsBnwLDR4XF?=
 =?us-ascii?Q?GNzXxkkvXDv8lF2UcYiUbbrrIkq2t3Snv/Lm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6568.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tTCznd/P4WS9AlaaGeAkon0ClizXDfidlqNS5zwhO2ji3wb4d5cNQmAZnVxE?=
 =?us-ascii?Q?vr597oSsWHOLcxDvwx/e3UHOFRLn+4dDvP7qeUTYSqNcA85aBYR1Ycz83yAR?=
 =?us-ascii?Q?pdL4RPXiE+jNC2/Bzj+C0lWD4cIGDEx5xWJYboPF+2sXLysk4MW9cts/Eeso?=
 =?us-ascii?Q?BwMuaCopXwTQqLsXDJCplxhKS9xva59GvaD2HGe5W+KrE3D91xvRb51W/jjq?=
 =?us-ascii?Q?g1Z7yDTazukuNs4pbFBtx8pWr+I4L5mBbZss6Mh+6oxTWj9+iuBdghhSUfbU?=
 =?us-ascii?Q?FKyRS2Mygk8ZSaVeXXZ022M5wLu2KEfcZGJ/9Z0v5KGNXOj/FAh8LheLn1qJ?=
 =?us-ascii?Q?V8Mpoo9Ini+fi0W8nE3G0+s9URNu9h+q4RGbQ9rqK4QTyShZYwtwwlc2Lttu?=
 =?us-ascii?Q?xET0WCD/VTD5p3vqOUDztAiSE2fymDH7u8J1THaNH/Zc65XJiFP1uINqJMUJ?=
 =?us-ascii?Q?bQN2vxlgFWlChB0wTuyKUP2mbQn2SQpHVMhEFZnZuuqSpMaq1/jFN7rLB/zD?=
 =?us-ascii?Q?JrTavYZbknvXno1vY9ELcDb3ogsanoJCw1XVOY9EUYnPVB8nDGhAY9Kf4a/U?=
 =?us-ascii?Q?mNDcd/E7nT/6GPP1Z4EbAin5B7s/ZtzdX9UuaibVYslMdjT9ljoT4/nb6BtE?=
 =?us-ascii?Q?092SQGZsMgnHd6JyKtbVtYAdh8Q3VT8XtwRL7+CvYf38eQ1bh2DLB0YyE5Tl?=
 =?us-ascii?Q?CtFji0NQ47xhba8VzyPukx8hm3mCLdr1nsp4GfK28AIkYVU2NP7VF4Z0Rt0O?=
 =?us-ascii?Q?Rq02e2mk5kG+CbyhfVsvPLiNgRO+hfEqBBXyv4nXTqUzlXQbSDGmNGntHl05?=
 =?us-ascii?Q?/Tdoj5c8DViVJ2KTKkN4RI3/+y2J3GnXYhlj+mPD/W5X2jaKY3PqXD8QLRxv?=
 =?us-ascii?Q?Ww3h703VzvedcmjJdn6V/tCF0zwJZMFFVJA9zqtlOEPAA2TgYqLMa2Rt7uXS?=
 =?us-ascii?Q?AwoLsFLgf933aH3bORE/53Pi8WkSIT5M0fwkmyj5x/JGy2sbE9yTycmqASSM?=
 =?us-ascii?Q?VljDVyup2zSPNVDgq3zEOaWYgWHti8dm3yE97nSRFvmRCgZp9qY7GWPvsYpo?=
 =?us-ascii?Q?lwrcHPufj8NL5cbkWAtpAUE+jpIp5DEzKBC/d1+dMYL9xGsiQ7/2IlU/14aK?=
 =?us-ascii?Q?O81J+7GuKpHPTwf/WmIsvUXR7Ux170gWZGiOGHVMU9roZhkyP1SXL0PDjtqy?=
 =?us-ascii?Q?yeUaBLTy9VQZPsKN5VNP/ntjFj23pdmn9IM7kb7oQW3YjN3tXlaCVzDgG7of?=
 =?us-ascii?Q?0gpRg6h/Cqam6Nh1ODCj7Sfk8z8IQk2rRz/xyjMB8qKoBKetbVjkJgg2pUO/?=
 =?us-ascii?Q?A2++Sg3n2tt/8N7ELgDyapsfuaDQnMcZq/omF65GHTaHtQDQliNrm54fsybz?=
 =?us-ascii?Q?KtmRA6NvRrpqYPcTUdzFvIDfhn1/+N0dj0Asj9oMUV/dznJOT8SjbcqJbzfe?=
 =?us-ascii?Q?d0T63CeS2qllTGaCDEhUYWlFzWjeZGEdrBt6oSNGWud3CVfiZmMvxv39q86L?=
 =?us-ascii?Q?fm6rDtyhg6hnayPHI/LtXkynVLuLc+pa7Gx7CuuMPKkhtdZvhOQtr52TpA5g?=
 =?us-ascii?Q?WurmjJGZKAHFtVmKh+NgtYdGZMHEQUuXMUZ1pAxylYayZU7b0a6vqWgLLdG7?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6568.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13448bca-8ce3-4ed5-a089-08de021f4534
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 01:50:46.1483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fi4Z+towlsnIA+mEA7vFuEobgnuJFojNxKiKAQmElCRvUuusifU2IBt4CHvrsgO/fmOO3rHWv4sBWiAnxL7gszV3wpc7lWKoSp4z3xcNPYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6638


> On Thu, Oct 02, 2025 at 05:56:51PM +0800, Jammy Huang wrote:
> > Add VIDEO reset bit definition for AST2500/AST2600.
> >
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> >  include/dt-bindings/clock/aspeed-clock.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/dt-bindings/clock/aspeed-clock.h
> b/include/dt-bindings/clock/aspeed-clock.h
> > index 06d568382c77..421ca577c1b2 100644
> > --- a/include/dt-bindings/clock/aspeed-clock.h
> > +++ b/include/dt-bindings/clock/aspeed-clock.h
> > @@ -53,5 +53,6 @@
> >  #define ASPEED_RESET_AHB		8
> >  #define ASPEED_RESET_CRT1		9
> >  #define ASPEED_RESET_HACE		10
> > +#define ASPEED_RESET_VIDEO		21
>=20
> What's up with the gap here? Are there another 10 resets missing?
Thanks for your review. I find this is just an index of reset map. I will u=
pdate
new patch later.

Regards
Jammy

