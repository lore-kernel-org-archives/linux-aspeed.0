Return-Path: <linux-aspeed+bounces-2841-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CE4CCFA1A
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 22:25:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3r8s4Y7wz3c1J;
	Sun,  9 Nov 2025 09:25:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762640717;
	cv=pass; b=AncNR0xB0eBD9z4KXzlwcStkgLOaNNzB409001cfbgBXFxbJD4MWKb5kbd4g8Nm5APt19evLYxNjV+PoXwlpoWgAnwZirPAMQyi9GlAM96yUpa/xCSOQdaO5jx3tN7QQLnjmptvuGnP7cIxCzTkcAuUnGvitUkSQgfP7MAUquTCkNEN8VLsGx2+oJJI0lHcdVm8Y3Ia+hvEJWAqrNhwlmkdQGVWJRsgOXBA7KCHOMK24OkvdVfVhkuDzBO1dGV8DBmPN2NTSmmx6bUuTemcYMW+3Mt6t2JFEY/4Y0dgaw4rlC7sXwuZfzdmZ0J7MfFOcSayQ1hU98oEbrEXSwiMRLQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762640717; c=relaxed/relaxed;
	bh=SV8jwzZGZy20gwFSpTKuFswn0Eym7rStniWJNN9MYiY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JB+f/6Y00rlo6TMa8OA1bYorOPQWxAg9KrLF42/nGn9RmiLn6eG3bhlwYYvwrUwZ227XLjE7QCiCerj7rANyacHf6pMIMZlbWtGla2igBlbJiJ65YCffk8xp5A+VLpDlhCkR0V0Ynvltv9p4/kQUjW2iXk0pIk1pIpw+yBM5yol+yGKHI7p1VAYqKn+u0LMo2U5rSt2KsEtcPbj/Zjq4ichVWv0GjFGTxGP6OlXDiTNOT/q4lBZpm86vRMe3cFS8IBKEay/TAInPD8hCyuxrm6gHEjkte7AU+vDQuHp2ofL05vz8G5G7rUP98W+9dkgDSx6Mk+oILO18qrGPOgxrRw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RH3Fwx7G; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RH3Fwx7G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::7; helo=cy3pr05cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3r8s0CL7z2xQ5
	for <linux-aspeed@lists.ozlabs.org>; Sun,  9 Nov 2025 09:25:17 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDrDNxXGYA6L60bqkXSPJRkcAGH3nGTEDomAo/GDo1wElOOC7mBkHfLQIIAZIRljRyAqmIdGTDWauTksCt4N+vF3alFHlQ2FFOeLpX0zE5dWJDVaqYu7z30AUb2oGrzVFwsXGcaASA5Vs4P6bhqMNt0BoJXC0WGJEQq66eVbCbYW7BU8RtGF7Y5K8PPm+YoGewKKQ9nQafVMpGID8rhAo/xqLaj973k1oudPsJmaOnEQAM7FHN7U92OwExa/9d05wkCA15hkKXW959ODIylS5Q2GyYt6F1e/T5qe5/fO6dSJoMnygyDu0J0TFYMhckHc9pQoJW6qDdeo9g7nJNrmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV8jwzZGZy20gwFSpTKuFswn0Eym7rStniWJNN9MYiY=;
 b=wvYh3qksJw+EiMTFg0dz2tS2S58F3GzkdhniBP5uiE5DFRPvL9OwdRp+rpZt3GYGIfcEeiF9TA16vEYNs9Pt8VuDb7LV4GQaWRcGRrffYSqWeGSWprKwd1G32HPr4Qwm6+6hEui0Imix/1fPVuUrBymb2e6YK8U0SWqrLDtn/SJoGNQYz058F0/Sr658xJ0OgRq7IMYu8AsbzHcXAbQkucZdtW1nQT5AwC7gigYwm557Vj7jlzHePQcGRpJNRnQEkH9SqfUKzZ6U2VifhSRKfLaoNsJpmCQ/GAjJl9L/seYUZ+oZm/Qm4s5yB4qAWM0+rxzDxqhirFgJ3DGMdndSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV8jwzZGZy20gwFSpTKuFswn0Eym7rStniWJNN9MYiY=;
 b=RH3Fwx7G5kDz4mdSoZL83j25+L1NWzaHbsuMvvmPLnh7ulfJ2Yi77CcCldfNPiP/ndvaOjk6RCDjbFbbdfcruG8ywgy7HyXNXj6aAMWzJXR4YM69soLdCH1TFySqPs8WGg7/1mVE/DIb37/vvWS5yf1zYVfSoYH1RlRN7LYyUi6cjY8i1VHcjeAdxFflVmukHV0tyUNdjXEXNLx/vRXfj7ukioTPSfMqyLoWgPKkdM1vYKZZ0Fx89fM8EM0MBeh3YoJokhLXVSWcnMgbXS4wCjAL6dMAfeo0LkYLt3H2Ys1ahndFqSsLczwbit4h4dZn4bkVtY6oAGhkEtzIS+RDww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by MN0PR12MB6056.namprd12.prod.outlook.com
 (2603:10b6:208:3cc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Sat, 8 Nov
 2025 22:24:49 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 22:24:49 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Sat, 08 Nov 2025 14:24:35 -0800
Subject: [PATCH v3 2/2] dts: aspeed: Add a dts for the nvidia msx4 hpm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-msx1_devicetree-v3-2-c7cb477ade27@nvidia.com>
References: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
In-Reply-To: <20251108-msx1_devicetree-v3-0-c7cb477ade27@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762640684; l=5431;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=advg6H9+W+gGil84SPFprKoGB4AcNYoY3ROTpo5P5hQ=;
 b=01ah96yj4Zfildbgsau1bUOs7/g47lHujIuiDGCY/dPvVQ4bsRA2NaQvRQ3yL79pZ2+1DsHHh
 and3iaIQqgwCPn7DVnKPvv1X4TBUTzqOX/82VA6g5U6lLlvSMZO2C7Z
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c0c602-613c-43ab-21be-08de1f15a11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lEK29QbEc2S1RpejNpelBka1V1RTBQYTJuQ0NXTUZlMTk0cHMyZlA0VGlQ?=
 =?utf-8?B?dFF4UkhrODBseWhNZDBGSFZsa3VwaktIZXgxWVZJZXAzblBMWGUxUW0rbGgw?=
 =?utf-8?B?cis1enI1WkhIYTQ0dU5TMTRhVkYwTlprVmQ4QXVjUlVvSnlkYlZieWk0a3Nz?=
 =?utf-8?B?TmNNSWdNR1ViM3pLSjNVSExFa0U0Z09YaFBOcVNIUUNFdmg4R01YcEVZOERn?=
 =?utf-8?B?aWc4OEY2bW9lSk5YclVaTVpZOFdMQnlXOXAxNEN6NjJqTm5BN0hBSXp4aXlD?=
 =?utf-8?B?NERiRjROVG41Q0xnNTlWdWFaNVBGYXBSZys0ZlByVVgwQXZnYkVSTEdZV2Zx?=
 =?utf-8?B?cEZJN2xkSTNPN1M1S2pLRTUzVlB6R2VzUVZjdXdtaitQTVR4aWpZWnRFU05x?=
 =?utf-8?B?cTNKK2ZnVHRmMzZLdzNud1dJdXhkSkJsVkt2VlU0QXhwMTV0QXdEWDh6bkQ5?=
 =?utf-8?B?RVB0RTVSOFJnckNMdnNZYUF2akdnSExsN012dDdnRFBvVHlZdDh1ZG1hTUI2?=
 =?utf-8?B?WHQ5VDloTW5hMnFrS3EvQndKYkNSdmluZFkxbDRyeGRCRGN4WGluSE5ZWFlN?=
 =?utf-8?B?dUZtYnpwSGsyZGE3YXVtR1ZRZnN2UWN4RG8xV2EyNlFBL1A4djduU1JnaXJL?=
 =?utf-8?B?ZmExMSsxYmp3WDFvYUwxSWFVRWxIUlNkbC9iV3AwVUNiVnRkUVhsNVZDWEg5?=
 =?utf-8?B?UnR6Rzd1bHgxNnZnaGgyM2N5bnY4Q0hNVW4wZVhVUitZazlKaUxvVU5mNlA3?=
 =?utf-8?B?cVd1RXlCWWVBOFo4U0lQbjVGN0oxZGpXR0xQWGQ4VVRweHlwenRaWmNCZEx0?=
 =?utf-8?B?MVNmYjA4Z3lZd2M4T2xFeGptTmx6K29uOWpxLzJJNUhHTlJGQ0JMZWxuclFD?=
 =?utf-8?B?ZmNSRUZjeXVkT0h1NGt1ZytYRUFxTHJLZUl5RDZWSURpUWFtUmJVY3JOUTd5?=
 =?utf-8?B?bkZwa1ZIdmFHMjF5TFFueHdTSGc3V3BkSVBwdXQyZzEzYkdsSi9icnd4Um5J?=
 =?utf-8?B?YmxaaXJFamJjdE1JV2hvQWVrWDFxZi9hZGJhK3FWVlFwY09MVG1QQ1RXcHp3?=
 =?utf-8?B?Yk5WbnlQejgwVU9SVXNaSlFDLzBOZWZNTnlzTkxvK2FDVEQyOEdYRFNLMG1O?=
 =?utf-8?B?dlBNM0kxM1RVTWtuQ3B4UjR6LzhEMVo1OEN2V2c4bFJweEZtRlllMU5rWjNt?=
 =?utf-8?B?REl3UEUvMVErb1RFTlZGZjVpRnZJbFJxOFA3Zko0c25RMEoyWmtVaWgrQUgv?=
 =?utf-8?B?TFlVZWxGalVyVGlVOUNBQnQvVUtsMTA2MklQN2REeDA1bXZUam1jcmdMUDN4?=
 =?utf-8?B?b3o3NmN5NXZQbWNJTTJxYXFmNHRqeU02dytTa2g2OFpIR0VrSUpiZzZyY2JI?=
 =?utf-8?B?emw4KzFrOCszU3JQRXF5ZGo3OHd5UTlPNG1IWmVqTDZsQkd5Q01OUllXUnFp?=
 =?utf-8?B?MHBVUWZCcXJvbHNVK1NWZ3ZYa0NISDIxb1JlWUxKa0tvMUkyUGtNRWxHNS9D?=
 =?utf-8?B?VjZlSmIzVjZVRWVnNExyMW9vMVBsS3J3T0tWd1lteElZWVV3YlJ6bzRUZ2hX?=
 =?utf-8?B?M0dGMWlWQWZIL0RzKzNnSjVlTFlidmQ3WlhnTGQxd0dKbWluNlR5UWs1VU5k?=
 =?utf-8?B?YURRN0tPSmNka1ZSZ3pJOTExSWZHNzRhVXlHeld3UG5qeFFVMHdyYUJUZFFs?=
 =?utf-8?B?TW9HOFlkUmVBSW1CbEtPZ0EzSGdLOHowamNBcWIrVHpqRHVZTUE2MUtKdWNL?=
 =?utf-8?B?Vnh6cFdRdm9OZ3U0YlFwRnlJcE1xcFNtdWxmVVdzU2VVZm5qVkM0RmppTTVP?=
 =?utf-8?B?Y2lReE1md1U0NWVPZWNwc2hvL1FXQkhYdm9HWTR1WkZZbGZGWHp0YysvdE9E?=
 =?utf-8?B?MjFnNmtLWFpHa2M4M0VCaGJMSmRqSnJPTEI4bUtwRkxjYXFBSmMwVksxRG1m?=
 =?utf-8?Q?snJeG58e5BeUTIIA4iJR2UR6czxwkZb7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJvM3paUHBjendiTERkRGM2N3M1V0o1YlBWSmt0Tit0QzJkclIzazBnMi9S?=
 =?utf-8?B?L2hUNGRtQ1pSNnJWWGJWWlFPWmwzWndlNVlzbnJ1VWFCZEk1eVVyd2Fkajhq?=
 =?utf-8?B?a1hiOTZlRkhsN0R0eUM5S0YvOElaMHAzdit0c2IyZzg3WU1sT3FrZlFkU0tC?=
 =?utf-8?B?STRwaGViSkdlb28wWTRYM0N0SEE4VkZKZGk5TjlFU0N1cVJGUXFqaEdhNUs5?=
 =?utf-8?B?MEU5M0prY2lkbkNwLzhwWjY2eGFJczByUHpJb0ZUZXNydHlXdGMwVU4zYWk1?=
 =?utf-8?B?UlYxaXNnUmcyd001ejFlZWhhM0I4S3JHdnovMnZTUnB2OVFCQmNCczkzU0xN?=
 =?utf-8?B?dUc2TmFMcWEveDd6QmpsUVgxYkpibSt3QjRiTkZhZ2l1eE0vUEtyQUdJYjRD?=
 =?utf-8?B?cDdvOCtUREl4UEdWY1BtUy9lY2ZKRXFLMSsyQ1k5bjNhcEllWkhTVEl1L1B5?=
 =?utf-8?B?UURkVFk2dHdXVHNobXh2SXRrUEp4ZFZxM05lR2U1ZUpqZEFqbDNTaWdDSmk3?=
 =?utf-8?B?R0dzM0dHVUphdjlibEE0M28yeGhTT1ZxOUU3OXF6VDFZdmdteFcxQy9mMTA5?=
 =?utf-8?B?MlA5elE2bXplbk9jQU9RV1pGa0dBUFBvWjByakRMTmR5VjJ6OXNXNFpTR1Yy?=
 =?utf-8?B?MlFpaitySzlhbEl2MGE4dGJyb2dHbzR5aUJVaSt0Y3VRczZrMGNjbHNJUVNZ?=
 =?utf-8?B?TktTSXk3MUFON2d3SmtoZVo3cVFHakhBZlJERUFLNWdpeW54aGN3akFyUkJj?=
 =?utf-8?B?WCtIb2lLUlVIV25TVFFXTmIweU9uK3p1MDdnWkhtYzNEY2Y2WDA5enRSa3c0?=
 =?utf-8?B?MlhXUmdTTmZpQlNtQnJvVnJlVHBQOXQzRk96RXFFMGM5YlE0b2k4cG54dnZE?=
 =?utf-8?B?NnNSamMybXdtTnNzTWp2aGpHRjJ0MjdoR2t6NEk2dUdpcUNtL2toOVpkbFlW?=
 =?utf-8?B?MXJUbTB2aXJEV290Z0RLVmY0azBrSVJBRDZRUzN6NDUrOUNlcXNTTDhwcmRo?=
 =?utf-8?B?azVhN1lMYnVBMlR2RnFVdmZrLzEyN3JVVkt2dlI2ako5ck1teWtvN0ZsTTdz?=
 =?utf-8?B?UkRBL1Rrb0lpbnlpRGFSdExMSUtLSlJ2bUFsVndMRVo0Z1dHR0VRY3MzQ1J0?=
 =?utf-8?B?eVRrRjRZMDF3WGp2dFVXeGhldjJVM1N2eXFhV2djbXJIekd1UUF1NldoVzRl?=
 =?utf-8?B?Ykt1WE9DNUR5eGw2QmdOWGVFajJnbDJnSHY1eTNZd0R0QlNXQi9LVXd6MXZS?=
 =?utf-8?B?V055L2JwaDBFZHZKVm1MNUpkOUtQL3BOa2RXUFpHckMyWDIvdEpScklhdUdu?=
 =?utf-8?B?U05Yek92TlhzbzdaNGM0NHBPZkdNTmhjM1Q5bXFNajlsUUwwek5JRnpsejBo?=
 =?utf-8?B?NnJUK3hkMlVRdDJaN0JpSzJYclFYb2NhUmtmSFdIbjE1SkFPYUhxaWtrUGpw?=
 =?utf-8?B?ckd4VWpRYW5IVVVHT09QTGtzZlEydlk0U21qTGRaUys1R0QxMmdCNGpudWhJ?=
 =?utf-8?B?Sms4QS9Wd0xUVk4vQllhNzYxcGZKM0s0UUVVUXA5K0VKeS9wcFdKbG05dGwz?=
 =?utf-8?B?M0hndHBEaVRFb2l2WDhvOHhEUHI2QUdQSmxkSnp2ZjhFeHYrdGtTczhCSUNz?=
 =?utf-8?B?SlJxZXpMZVBFeFRYZm9rWUV0WjFsRG9zRXVRaTVSMm5DV1Y4R2wxWERIWlRr?=
 =?utf-8?B?Wkkvc1lXN2tQNTBlc2lVNXNzcVJqVmlvWUxUWVQ5VVBMUWNsNFRMQUpYcy82?=
 =?utf-8?B?bnIwekpRU2duRTNaNy9PTFZJTTBvQkN5WkNQMm1OdFF4QVY3ZjVHdnFYRmla?=
 =?utf-8?B?eXVWQ2t2SGk4ZCtPMFpXL1hndVVMSXRUSTZBUk9IbS9YVUdIV3V1WHBWV21z?=
 =?utf-8?B?Ni93T1NrK0xwYVpQK1RVdVpSWXlNRm1HM3ErWGRTS09SVCtWTSs5TGNiTmV2?=
 =?utf-8?B?bk5tRlY3cFlybjRSMVB3b05NUDlSaTVoa3BLT1pPRUgyZFQ2V04rUUJQbnpT?=
 =?utf-8?B?aW5Kd1ZPWm5MNTdjM1dpUG44Wlhqeld5aFdSVi9LWVBuQVZkT3gxQnpWeFM4?=
 =?utf-8?B?anhNWDRCSEM1cVdSQkZ3dzFHcytxRmxhWW5lWWRpV3ludVVETnhRaUFnRXky?=
 =?utf-8?Q?yACSyc4fL+ilOTTHAjDguDYRw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c0c602-613c-43ab-21be-08de1f15a11d
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 22:24:49.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muF2CLx9OL86xSyUJ0EI7fwx4bISGwJ5UzBZlj8UKqA9DrezKsSYcD6kIDdmOLj2ymoiUpRcpeHKk5DYHjVqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056

Adds a dts for the nvidia mgx pcie switchboard reference
platformi hpm. This is a dual socket granite rapids based platform.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 235 +++++++++++++++++++++
 2 files changed, 236 insertions(+)

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
index 0000000000000000000000000000000000000000..ad476a093293f807c04f7e70858af1f557c17370
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -0,0 +1,235 @@
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


