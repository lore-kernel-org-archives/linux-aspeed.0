Return-Path: <linux-aspeed+bounces-4981-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B55C79FB9
	for <linux-aspeed@archiver.kernel.org>; Thu, 10 Sep 2026 07:12:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgTQc1GD3z2y2L;
	Thu, 10 Sep 2026 17:12:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789024360;
	cv=pass; b=kG5laqojfP+CS7VorpsMkDoJ9kZptDk0wJwtf7iZO05GLYrJhdY4xA/Quvh13ENHT8wYrzkrnzG6opIycaVl8fRWGOsGmReRdViGe8HCTHk5Ok17BsX3CmX6jSl9vypZBhx3ibC3fnWUkurzwYwHjF0unMEtQpZz0q5Q/l01zfHAl6lFejvAh2Skq47CconPQ/h0oZqiiJ2Z/waoIPrk/bH4zphO4qOOzmlX6KUpMYVeZEWC1nEt9SdJIfZFZxxP8Nt0PWW/nD45M1w03A5jWodWTO24UM9t83GCRUkYt0T05AQZ72CGbln3XBxlmps6is/WIlpnFxotJPtngtDs6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789024360; c=relaxed/relaxed;
	bh=8Nzwqvg6i42VbzEiTRPHCrC7KL3wP2LTA2apPDw6sf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TTDCwawE7apV1D2llyHP3bnK9p1caKTk/R0d4jT9ET2ndd20G9xT3S27GH+UtQYdUTXoLQDQdRRQxpCSsO/OhhD18zUaH15IzX8YfJh1qCYYjEdYLhsYPvSFtg++wsYcy8qnVCaPMkKLGlW+CcWem2ZZBb73XIMHo8BSZ6y0l6cW8T+o+eYThS+U7YfdW0icbOrFbU4RBLH6+4FV2ipiSEm68fazyEtEtATs0bY5gLSFCMBM8b4j8stycPJvwX0aaJvG6CQMwQtiXeDrccYX65SVf/hwwCvu4jdgF6FXfwiKeAVdIyMI+mD8JGOr4q9L3SQ2qACiwJte5eAROyBYeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=R5IK0S9+; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=R5IK0S9+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgTQY1mdjz2xYh
	for <linux-aspeed@lists.ozlabs.org>; Thu, 10 Sep 2026 17:12:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S57lRtm2UyCyleYA2560y4Et6kJVIyIRUVjJT777y53eSfyPrIULePBQGdfIzUGRQZ1KVCib/VjKvifz6ba82P9vvRLnL2nUkylDBqwqet+6MMNW1625dp4uGYvuWNnwPH72CQvHL7+rcICrfS04mJOf4Si72lyY+u9HZULVWEk8bv/ZbBXAwazYTeJFx3kL7xKU9Gbl1SMRgGvyLLiIh0z7TJmyFYHv9J9vH8Vfd88fhL4ZSOjxhkw4wGRoDQ+cs7Oa/Smn+cm0vhoLCKAWRUYROHtT5fIk4wEDYf4d+Plxy5UZxQmCiplhnD2rseKtUv40fT4WU0LzraBlN7vGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Nzwqvg6i42VbzEiTRPHCrC7KL3wP2LTA2apPDw6sf4=;
 b=WXV2LHLhUo6DgbX3WT2OekuaDqzu0yPPuwd/maKs+nr4mY9M2X3mozsBIGrlbk3Ga0x9N80YSOUpjqtGioHWI7IH80KvrunaRI7K/EkaAYrJgIJqhB/nSTHkWVTkdbFHsHIONcDq9+tkI6o+rZEINM+cMeCbxkhciufiazcH852OyLPwILpYf7ITTELcHPRfJ5AfsMFq4EQO1hw7Z0waV2WwU9PFszxumEVqO7Uqd0LlOcb+XThiVfqQECGr6NOaXR48CZVa6JCJxZEA/UIkIbj6rxnTUMmstpKkwGxCMjKmxs3Ueqf0HMZYKvxsWjwmhQbQfB38yQgnj4mQItgpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Nzwqvg6i42VbzEiTRPHCrC7KL3wP2LTA2apPDw6sf4=;
 b=R5IK0S9+QPq2tuSEiIPW9nV2VMeAf0dmk+yCAvR0VyfPB/G+ybDENUUamPc2XUkgLSWBLWTZrpQJLaTuTvGuV7LoOsok4ttB4JZmiEuJ+ulZlFP4LSeSWFKyk1p7zT0nlbmShAyt0FrIdeAUVdYpcT0ojUifPCrhwEaad8xhAi3+dHFK3DCKq90FLU3SSKTh9PS78zY0eCQFAa3RoxMj2AGRgDTtb3osqn3Xe3ATfEClkSwhq//uWD+lk2eQshYkp3zhxAygJCR3v9tqxJyjTQMBHKetziZgOivKvTzzWW8tyB1OKpVHp+a/TQrUTQ77Z6CVag27O7INJ5sjei2hOA==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by SE2PPFB866C6F72.apcprd06.prod.outlook.com (2603:1096:108:1::7e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 07:12:12 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:12:11 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/3] phy: aspeed: Add AST2700 USB3.2 PHY driver
Thread-Topic: [PATCH v3 2/3] phy: aspeed: Add AST2700 USB3.2 PHY driver
Thread-Index: AQHdCScCoX24hLRfbEaIJdR+kSJSpbbGWNyAgAF7/KA=
Date: Thu, 10 Sep 2026 07:12:11 +0000
Message-ID:
 <TY2PPF5CB9A1BE673554B1AB3B7A7978CEAF2BF2@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
 <20260701-upstream_usb3phy-v3-2-00e12315b6f9@aspeedtech.com>
 <5oamvlreciw524g3bpbemcpdpljc7thilejy6s4kwmt5hdjwcp@xmaef4eaurzk>
In-Reply-To: <5oamvlreciw524g3bpbemcpdpljc7thilejy6s4kwmt5hdjwcp@xmaef4eaurzk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|SE2PPFB866C6F72:EE_
x-ms-office365-filtering-correlation-id: 93c7910f-fd47-4150-99f4-08df0f0ad5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|38070700021|10067099003|18002099003|4143699003|56012099006|22082099003;
x-microsoft-antispam-message-info:
 +MHcfpC5x5GvfUCYjKh1hFW9cp5b9onPGfy+L2dMmnM3F/02/3niA3/Mc2X21M8rSlwBTirW+OGVqdoo0nKklHr8BMhgwUaxbiRIHFb6z1ZfVhN83I/0wLwzDvC+/NdGNsx3CSsPzlHvJPVH6AXo1Tr1d5tnCbux6RWe7d03AZy2vHUWiH6iNO4YCkKNkSfjc7WpIDpedUHM7sYgBBVWMS1i19NmzMRCVslBm+jm7CANxFIjWLEPdmSUaMWyx9JBuGnSaPWqFQVMSaGweR+7jVicOl43dZlQ44xo/3CbMGvaarbMdXZRsJsjnte/16ZLsWWcN6om571Cm/GuuS46jxIarFeJNFl70Fnw8SfsVcDxKIGxvFMlLyBmk6uMyx5TjCZSrDGswY7Nf1B+qTjXGsVPxUjP5eS46cz+aVfpuTlzgHHt7a1sNx1YNtATUrHt7lMvHlfkfSTtTD+0Q+jM8J5wITMNZDpXEbj/s2v4ntK+VrylwrFc973QNGnVMk2KUS6X2NCnkwy6mpCHQgGjkFJZYtVQjgdzyx9j4ylGFzalrpCEj7zhunYDZTu98K5cg3wE2PnMCigQKfvC8Hj7h+RjwoBdPMK+3i+juVeZuE7zL5nHaNJgc5w/fAnv+aaTtWR8Fc8HCpxNTzVcK4y5gOUDFoK2sb81AkuTiWiQVpIvDHL/r0v1weWxFu4FIG9dXzR2QxcLZBQjG3Ce91APqgMEdqZnvKOZbQw/zpjDlF8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(38070700021)(10067099003)(18002099003)(4143699003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkJ4YlNPaFVJOGRiS05scUJCT2tzd0JNd2s1N21QSjBDd24rZU1EVC9HTW4w?=
 =?utf-8?B?UUFFdWxLdEdabDc3VTNTWmFwVkpBZjVnTW12R0haMGlHdVFSenNodnpIMVAv?=
 =?utf-8?B?Nk1ZTnZaWDlISmVxVW5acHdPUlB2Z1dadllKYWRiQWxvR1ZDNk91NG1obHNI?=
 =?utf-8?B?ZjhqR0Q1Zmc5RGlkLzJyZ3lkeklEc2R0b01Ob3F0a1FFVElheEdtaWF0d2No?=
 =?utf-8?B?QkxMOUVWZUcrMVovUE80K05OK0NacHRjWTNIT0FrMDhmMDA5c3JPZVNFWXJS?=
 =?utf-8?B?cTIvUEJrMUxLWlJqM0hHNGZaWnVKd1dub3U2U0owN20zcDZWbFQxNmxLU2Ex?=
 =?utf-8?B?QlN5MGE0cHlQNkdUY2ZnNmg3QkxwbTNULy9Dd1hwVHIrRFlkWWFSM2Z3WGVN?=
 =?utf-8?B?am1ySzVKc05oTHQ2Ynh2bFZMM1VaT2hRSlZhbDZGbVMydE1aTmN5SzNNZ1Jp?=
 =?utf-8?B?VEwzS2Yzd0ozd0tSOVIwU05xbEI1Mi91UFc2cGxCODNSN2tFYjBZRlhjOWx1?=
 =?utf-8?B?TjhEZ0hVQ0NNNXh5OE1FUmJoQzZkUVFFMjBzZ0wwL2pCaXdSL3QyejZBb2Zy?=
 =?utf-8?B?KzlhMTBkbjFzZGI4NzFlcW1sM1l0ODhjTG9nRGZISkx6TlAzTGg5cTZOWDVY?=
 =?utf-8?B?blgzSWJjNE9BNDJ1TzJFWWlGZ0tIZEU3R0IxdVpXRFlKcEdwMjJGZGgyeHdT?=
 =?utf-8?B?K1BvU1FzV3BrSklZVFNyYjcySjJHbkc4VDBIZHVSS0FOOEFob1RWSnpGZ21Y?=
 =?utf-8?B?VDYvNUlzMlY3UEVjQUZxb2NpV3h0TFhKSEVEZkE4QUwrYWZVQmdydW9WeERN?=
 =?utf-8?B?bWZQL0VRMkJXNy9WTmhBeHRrMVRHd0o3UDlWNXk3TUxzTWtsOU9LM3RmOTdh?=
 =?utf-8?B?R25RU0NDZWU3MWs2R1hjNzB6ZDBHeks3cmw2cDViM1BtWHBUTjc5RkF3N1dI?=
 =?utf-8?B?ZEdRZUphVzBBVHZVZ0NqSlJhZWE0RWIzamdNa2dmK3g4QWM0QmVvZTlkOFpU?=
 =?utf-8?B?MTFHZnhoT1JFRkdxUVVIZllWL0F6bTBMemYyc3FHTjdMUEo1NGJvWmZIZzVH?=
 =?utf-8?B?MzIzVDhFOXgvWjNKelh0RUZERDQzbEFWZmFVeGtvRXdSRlpZQ1crcjBKSUp1?=
 =?utf-8?B?c2ZMa1BJREdjNlBKUU92RnZUYkp0eXBqc3BkS1QvVkQyZ3pTMFdXeThKSFhO?=
 =?utf-8?B?V2VtWnQrMzIvelFzYXZjSkZST0RUeUw2QjB5c3ExZ3N2MW1rb0JUb2lVZjZi?=
 =?utf-8?B?UUdrV2NVK08rVllPMEI5bWVmUmoyUWhuUGhJUmxaTGVVZTRzclRqUnp2UHBr?=
 =?utf-8?B?SWdoN0RiYTdxZTNBd2JrQnhjSlliRWVUUHJDS3diekQ2UmVWelk1ODhYNGQ4?=
 =?utf-8?B?ZERSSW1yRklxRU9PSW1hNWJ3TlZaeVRrSXhySWNLRi9FL2NmaXY1dG1XRFh6?=
 =?utf-8?B?bC81YUNyeG9UZkptdHo1dXdGYkdqbmwxY0VPcXY3VFZJeHA2MUxXY2NqRmxr?=
 =?utf-8?B?b2RJTGovdUYxMzQyck8vWjU3S3I2dWdZUUN0Nk40MkNoN2YvSlpidVhRbWNH?=
 =?utf-8?B?dmh6OFdsRFdDd2xGV0JFVWswTlIrYXBqR2kxbGwwVHZTWWpTVHo2cDJMLzlu?=
 =?utf-8?B?cldUS3h1MCs3K2xsVWNZT2ZrSlFEQVlMWHEwSDhJT0xmbHUxTmw0UUkwYTFn?=
 =?utf-8?B?bmhiKy9senJ6cXVONHcwVVRFSFJINlVtUnFmaHk0ZkpmUFYvb2craDhsazlN?=
 =?utf-8?B?dU1aMjlnZUpEWGZuZ3hPQ1dvVDVZZWFkVUhJVm1QaFJlUmJoVHJuQjF2TUJX?=
 =?utf-8?B?OEZLVUVyTGdxdUxnUmVoYzJLSXJ5MWZDUk5pOHBpdzEwbi81dEZjNmFCaThq?=
 =?utf-8?B?UmFINThDZGlZNitqbmVZVDVRYzJpVVhVMmRWYlg3NytZajhvWEFBRU4vTjdu?=
 =?utf-8?B?UERtdlBPVGhTcTdnc28yQXY3emRCYzR4d2MvWUpnajVUS2J1NnNQbWgwQTVS?=
 =?utf-8?B?WDl6VCtrTFJ1Y1VURm1Qc0dxMk42RjByRG9tYk90L2pudUdmekYxRUtnZ3VB?=
 =?utf-8?B?eEJOQS90d0pRK0Irck9lRFNkTGVYczhsL1orREhxU1lkK051VGlHN0F6REtm?=
 =?utf-8?B?d0I0alk4SFd2T2dUZnF4OUtKcERkaTl3NHpXeEJDM3N4L3VDbGpLUWNQTVgr?=
 =?utf-8?B?Y1NZMjU4WmRKTTBnS0tuNVN2c2lUc25sUFhkWndIbTVLNFp1bDdYemZwN1lL?=
 =?utf-8?B?OWNaVVZIbDRCWHE5clk0RTBDVS9MUWJCQ2krYjRKazJMd2lQWmlGdTJ5SkI1?=
 =?utf-8?B?OGdsaFVDck9PcU92WWlaZEtOcVo4N1FhUVZNalNPVWgwdFpIOExKZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c7910f-fd47-4150-99f4-08df0f0ad5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 07:12:11.7883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EBx84yaHGWUG6FgwpxFn1RxrUNIucE37BioLZqwgQVxFbxuljgOqQjjB4J/fYeqYFM+Xyzmoo2JQQYGtk/tAVUm9+woNIrXYuhtCZZOUtic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFB866C6F72

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvM10gcGh5OiBhc3BlZWQ6IEFkZCBBU1QyNzAwIFVT
QjMuMiBQSFkgZHJpdmVyDQo+IA0KPiBPbiBXZWQsIEp1bCAwMSwgMjAyNiBhdCAwMjo1ODoxOFBN
ICswODAwLCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gQWRkIEFTVDI3MDAgVVNCMy4yIFBIWSBkcml2
ZXIgc3VwcG9ydC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJ5YW4gQ2hlbiA8cnlhbl9jaGVu
QGFzcGVlZHRlY2guY29tPg0KPiANCj4gSnVzdCBjb3VwbGUgb2Ygbml0cGlja3MgYmVsb3cuIE9u
Y2UgdGhleSBhcmUgYWRkcmVzc2VkOg0KPiANCkhlbGxvLA0KCVRoYW5rcyB5b3VyIHJldmlld2Vk
LiBJIHdpbGwgdXBkYXRlLg0KDQo+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0N
Cj4gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBvc3MucXVhbGNvbW0uY29tPg0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9waHkvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAg
ZHJpdmVycy9waHkvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgZHJpdmVy
cy9waHkvYXNwZWVkL0tjb25maWcgICAgICAgICAgIHwgIDE1ICsrKw0KPiA+ICBkcml2ZXJzL3Bo
eS9hc3BlZWQvTWFrZWZpbGUgICAgICAgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL3BoeS9hc3Bl
ZWQvcGh5LWFzcGVlZC11c2IzLmMgfCAyMzYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDI1NSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvS2NvbmZpZyBiL2RyaXZlcnMvcGh5L0tjb25m
aWcgaW5kZXgNCj4gPiAxOWYzYjdkMTJiN2QuLjg1ZmEzODE5NzhmOCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BoeS9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9waHkvS2NvbmZpZw0KPiA+
IEBAIC0xNzEsNiArMTcxLDcgQEAgY29uZmlnIFBIWV9YR0VORQ0KPiA+ICBzb3VyY2UgImRyaXZl
cnMvcGh5L2FsbHdpbm5lci9LY29uZmlnIg0KPiA+ICBzb3VyY2UgImRyaXZlcnMvcGh5L2FtbG9n
aWMvS2NvbmZpZyINCj4gPiAgc291cmNlICJkcml2ZXJzL3BoeS9hcHBsZS9LY29uZmlnIg0KPiA+
ICtzb3VyY2UgImRyaXZlcnMvcGh5L2FzcGVlZC9LY29uZmlnIg0KPiA+ICBzb3VyY2UgImRyaXZl
cnMvcGh5L2F4aWFkby9LY29uZmlnIg0KPiA+ICBzb3VyY2UgImRyaXZlcnMvcGh5L2Jyb2FkY29t
L0tjb25maWciDQo+ID4gIHNvdXJjZSAiZHJpdmVycy9waHkvY2FkZW5jZS9LY29uZmlnIg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9NYWtlZmlsZSBiL2RyaXZlcnMvcGh5L01ha2VmaWxl
IGluZGV4DQo+ID4gZDdhYTUxNmJjYzQ5Li5jNmRkMDIwMDNiYmUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9waHkvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9NYWtlZmlsZQ0KPiA+
IEBAIC0yMyw2ICsyMyw3IEBAIG9iai0kKENPTkZJR19QSFlfWEdFTkUpCQkJKz0NCj4gcGh5LXhn
ZW5lLm8NCj4gPiAgb2JqLSQoQ09ORklHX0dFTkVSSUNfUEhZKQkJKz0gYWxsd2lubmVyLwlcDQo+
ID4gIAkJCQkJICAgYW1sb2dpYy8JXA0KPiA+ICAJCQkJCSAgIGFwcGxlLwlcDQo+ID4gKwkJCQkJ
ICAgYXNwZWVkLwlcDQo+ID4gIAkJCQkJICAgYXhpYWRvLwlcDQo+ID4gIAkJCQkJICAgYnJvYWRj
b20vCVwNCj4gPiAgCQkJCQkgICBjYWRlbmNlLwlcDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGh5L2FzcGVlZC9LY29uZmlnIGIvZHJpdmVycy9waHkvYXNwZWVkL0tjb25maWcNCj4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLjdiNWY0OGRiMmJlOA0KPiA+IC0t
LSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9hc3BlZWQvS2NvbmZpZw0KPiA+IEBA
IC0wLDAgKzEsMTUgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
bmx5DQo+ID4gKw0KPiA+ICsjDQo+ID4gKyMgUEhZIGRyaXZlcnMgZm9yIEFTUEVFRA0KPiA+ICsj
DQo+ID4gKw0KPiA+ICtjb25maWcgUEhZX0FTUEVFRF9VU0IzDQo+ID4gKwl0cmlzdGF0ZSAiQVNQ
RUVEIFVTQjMgUEhZIGRyaXZlciINCj4gPiArCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiA+ICsJZGVw
ZW5kcyBvbiAoQVJDSF9BU1BFRUQgfHwgQ09NUElMRV9URVNUKQ0KPiA+ICsJaGVscA0KPiA+ICsJ
ICBFbmFibGUgdGhpcyB0byBzdXBwb3J0IHRoZSBVU0IgMy4yIFBIWSBvbiB0aGUgQXNwZWVkIEFT
VDI3MDAgU29DLg0KPiA+ICsJICBJdCBzdXBwb3J0cyBTdXBlclNwZWVkUGx1cyBHZW4yeDEgKDEw
IEdicHMpLCBTdXBlclNwZWVkICg1IEdicHMpLA0KPiA+ICsJICBIaWdoIFNwZWVkICg0ODAgTWJw
cyksIEZ1bGwgU3BlZWQgKDEyIE1icHMpIGFuZCBMb3cgU3BlZWQNCj4gPiArCSAgKDEuNSBNYnBz
KSwgYW5kIGlzIHBhaXJlZCB3aXRoIHRoZSBEV0MzIFVTQiBjb250cm9sbGVyLg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BoeS9hc3BlZWQvTWFrZWZpbGUgYi9kcml2ZXJzL3BoeS9hc3BlZWQv
TWFrZWZpbGUNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwMDAwMDAuLmQ5
NmQ5ZDczYTAwOQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9hc3Bl
ZWQvTWFrZWZpbGUNCj4gPiBAQCAtMCwwICsxLDIgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMA0KPiA+ICtvYmotJChDT05GSUdfUEhZX0FTUEVFRF9VU0IzKQkJKz0g
cGh5LWFzcGVlZC11c2IzLm8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvYXNwZWVkL3Bo
eS1hc3BlZWQtdXNiMy5jDQo+ID4gYi9kcml2ZXJzL3BoeS9hc3BlZWQvcGh5LWFzcGVlZC11c2Iz
LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWZm
MTQ4ZmFhMTRjDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcGh5L2FzcGVl
ZC9waHktYXNwZWVkLXVzYjMuYw0KPiA+IEBAIC0wLDAgKzEsMjM2IEBADQo+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQg
MjAyNiBBc3BlZWQgVGVjaG5vbG9neSBJbmMuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiAr
I2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiArDQo+
ID4gKyNkZWZpbmUgUEhZM1MwMAkJMHgwMA0KPiA+ICsjZGVmaW5lIFBIWTNTMDBfSU5JVF9ET05F
CQlCSVQoMTUpDQo+ID4gKyNkZWZpbmUgUEhZM1MwMF9TUkFNX0JZUEFTUwkJQklUKDcpDQo+ID4g
KyNkZWZpbmUgUEhZM1MwMF9TUkFNX0VYVF9MT0FECUJJVCg2KQ0KPiANCj4gSWYgeW91IHdhbnQg
dG8gbWl4IHJlZ2lzdGVyIG9mZnNldHMgYW5kIGJpdGZpZWxkIGRlZmluaXRpb25zLCB0aGVuIHlv
dSBuZWVkIHRvDQo+IHVzZSBpbmRlbnQgdG8gZGlmZmVyZW50aWF0ZToNCj4gDQo+IAkjZGVmaW5l
IFBIWTNTMDAJCQkweDAwDQo+IAkjZGVmaW5lICBQSFkzUzAwX0lOSVRfRE9ORQlCSVQoMTUpDQo+
IAkjZGVmaW5lICBQSFkzUzAwX1NSQU1fQllQQVNTCUJJVCg3KQ0KPiAJLi4uDQo+IAkjZGVmaW5l
IFBIWTNTMDQJCQkweDA0DQo+IAkuLi4NCg0KV2lsbCB1cGRhdGUNCj4gDQo+ID4gKyNkZWZpbmUg
UEhZM1MwNAkJMHgwNA0KPiA+ICsjZGVmaW5lIFBIWTNDMDAJCTB4MDgNCj4gPiArI2RlZmluZSBQ
SFkzQzA0CQkweDBDDQo+IA0KPiBVc2UgbG93ZXJjYXBzIGZvciBhbGwgaGV4IHZhbHVlcw0KDQpX
aWxsIHVwZGF0ZS4NCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N
4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

