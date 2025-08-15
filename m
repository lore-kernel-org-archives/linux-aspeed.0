Return-Path: <linux-aspeed+bounces-1989-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F19ECA0EE4
	for <linux-aspeed@archiver.kernel.org>; Sat, 16 Aug 2025 02:01:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c3hzY1DXHz3ckQ;
	Sat, 16 Aug 2025 12:01:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2407::619" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755287257;
	cv=pass; b=QJg5W97MuFa8QQ15RIUA3HL9HYze5Uj/Kd6WfR/6TsgWuJlIwFPL83vC3OoFdhv4cJy4ChV8UokbPubarJAqpg8JWgikdDdjX33FSC+03TnoFXLQTjSQeCKRCLwp+5GzytcKZtogzjIKewcOKo0Jirum5IR8A25QmtMsHLZQySUOiRVfXHCMxdXGegDjBLZa/QMrp2vfJDa2EH879BwjzHukqwsWHcZu/pqVCtYGYjKdKEda2ji68r2hHRMDpyovoIWGcUj8eBsJyiD8GPN1S+1LptX2In3QD5Ifbjutj8CkZ7JcYM2tJ3k1NRmSYLywQUG1vjq6AESGWllOuU7UEg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755287257; c=relaxed/relaxed;
	bh=EaYTN8sU+nUxXAX6OVl0FytYehpEjH6cygwuTdX493I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=H7kUg+5R6hwC5zfDhw6FPiBhFdPBrqaTKDwqtxmQY/ssv8oYztmIuXWN7DF2nn3buu7w0/hwET3lElmuGpnwZ8YUgyMsZ5yiRrduiEeMf0dSqQRxa9QZl8OubsisLQmstzuLBX/IoloAOQ8+la24vWkS87T0GT5gIoAy6S7mevnxvyQwBo5Y1rDGTZVleB61anTiI6BMPPUzuX+n2ZLZI6tDWZBnBvoJIw5RrPhDDaWddULQIUXElEjF/I6+HEHolTYhUEgKyx67/xWCq9STPWYrZct+WgyVQR/ewSeaXR4s2iUlntK3ALkQuAAycVq3/LZMJgzOkOYoFfDQEbqB9w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S+aujoGq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=S+aujoGq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2407::619; helo=nam02-bn1-obe.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f403:2407::619])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c3Xh84KdLz3cj9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 16 Aug 2025 05:47:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XriXUdDKfE1TU8vZSqTy+0kq8YRUuwHKJ2+vNSfOkPIslXnLsmouzZ6rqqHllk2+s5dEL0iZBT4SmJHD+JPrD21HSdDJhnas3k11mmBg9NOAs4jVOeM6OlwDRyrO6D2az3KQAgqtMw6L5nHO5xuLF5nQQ0lOU0r5MCy+2vnhPjgbx/4GnbQk5ED3WXo4AVLp8Enc859tyQExaRevadvRBPMtpjZvpuVlz9yKZPQOfWG6XiOxYcvpL2Y+KzuaK4XCydMmjU3BtJBxB0GlYD/acV7jWRGmZlVx/DRymdXwWPWKZ1YDxTeINoJEG9FtqwBvpO7/KlIUA3LHLaNnTQ66Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaYTN8sU+nUxXAX6OVl0FytYehpEjH6cygwuTdX493I=;
 b=ptmG9+iFZeR3eA2w3TunjynhQ1M2Ex468Efu3LcFA3pVkR8nWgtt3yWQYicGHneNlFJkbzDPOTjoZ9IUD7/+mIVY/f1h7UC45X/KXopNVgBd2AZ0ID1toxJq+ezIP/Wb6VnYiedTJTyGCQxAJ8Qtu7CUqWmI1YukuvKVg9IvJb52NfKAAQevvqadU6miRBUs5JlCyReYlJihL+CzR5q+NIXIpKiz2+Ys/ezOFVb+765SvejUhhfcz9CiN8t+K6FJFL/BWyoaYDEElYuH+EWgtfeR2+hKtLKSDnHyYfio7V2vugYhGZDMpZP37wsWG3nW3KObc0SvyXBfqpYGUchG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaYTN8sU+nUxXAX6OVl0FytYehpEjH6cygwuTdX493I=;
 b=S+aujoGqevGjwcR86TAMHUjcpfhI2dpmPa2fRjHOay+Xm9fQXMTueXjHiF4dsKK/SbFacPg2tFh1nMO4xWwmhO0xhqJwhPHalIv0O1aVP1Fl4o9OqoYc/iQPBarSsmXi6OGEDmhjXs1I9TyVl9hKavUF9s4W6aoJ+YHJO8gb7oTN/JtYDkJIpHr+eaPvHwAEVdZe18uGR4QBPFjFiNS6L+PlktqkxIW+jkxM59YxmcKid4Pkm7I3fanUXYRfRnpjyyxSX7dA6c1iXMrJwDHEsCPTf+H8D5ox39ti18IOShHBolL6xoimWVUPDjn0de2JMkdyX4TqFvcUI8MnOGgmIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SN7PR12MB6864.namprd12.prod.outlook.com
 (2603:10b6:806:263::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 15 Aug
 2025 19:47:16 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 19:47:16 +0000
From: Marc Olberding <molberding@nvidia.com>
Date: Fri, 15 Aug 2025 12:45:57 -0700
Subject: [PATCH 3/3] ARM: dts: aspeed: Add device tree for mgx4u BMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-mgx4u_devicetree-v1-3-66db6fa5a7e4@nvidia.com>
References: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
In-Reply-To: <20250815-mgx4u_devicetree-v1-0-66db6fa5a7e4@nvidia.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755287229; l=22479;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=Bcrtnbi9X5ZXDpqaVZVCM4hHS7WEcvxTgFRkx5W7lew=;
 b=G81of4X3b/6hejPHcmVdkZ3qSylONV7GctX6HkEDFFXDHCzXtOkKR5pNZ6JChWXI6ymUU2pQO
 pWD00FiCyE0DyplOT4Gg0BJl/cM8QdeQ2tGugUg1KJWYEU6/tQ+PkXz
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f682995-356a-45db-8bd0-08dddc3489c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3o5SHhibDVXbEdPOFRrTVE1Z1FCK3pjMWExZ24vblJkS1ArcjVHMVZzQnFO?=
 =?utf-8?B?WGl6TFo2VnlmL3RiREJZclNKZkYxUTFrOE1iYzBicWJXNjFYcExlZzFvWU03?=
 =?utf-8?B?TTdmaFdxUVR0aHJ0U0hMYVA2bVdTZ3Y0TitIbW1LcTFMdndLMUFpQVFGVWJ4?=
 =?utf-8?B?TTBmRnlqSGNPT3BQa3NoWjBhc1FBQ3RJMmFZaEdCUGJZbzlsdWFxSDlLY2N3?=
 =?utf-8?B?V3owcUUxTVZnYzl6ZmFuUnpXVlRYUlUvYkg4MHBpMnk3eDJ4VGc3YStFcFpY?=
 =?utf-8?B?VXdjeXV6YnZEanVUZ3dsUlViUW9uMVdnNXA4RkdkcFF1Vk5TcTd5WTV1a3lv?=
 =?utf-8?B?WXNocS9ibUs2SitNRGQ1cnFaNG1qdi9LWUVrRlZPbTN5U0owTm13YnpDYVNz?=
 =?utf-8?B?aHJJc3dCWG93S1pjNm9rdjQ5TFc2TE9NUEwzZ1pNSXE5S2diYkJFcmhLMzNv?=
 =?utf-8?B?MlVoM1g0L1REcDJlaXVKVmNzNUM1NjRlTHdsSmsxNzJSbXYwNWE4OWxxOHJa?=
 =?utf-8?B?RjI4MHdYU1JKbS92YzNmbElpNzNMQ1ZBSUY2cFZObDAySDc5VTZCQnZqMUFT?=
 =?utf-8?B?MHZlanBZc1Arazd0enBBTnQxWUVKWmUyWGhZdVNYVFB1K1NPQVJIVmQvdzYw?=
 =?utf-8?B?TURoeXB0Rnc3VjNuQTVjYUtUci9LR29sUEdrdGxEaEk5Ung1c0RYQWNJWXcv?=
 =?utf-8?B?Zk5GUG0wWVcvMzdYNkFIT0c1V2dWOFEyMHVDU2E1SjAzOGhQak43NFJwMmFD?=
 =?utf-8?B?MHlRTlZhdEdaVDFHa0NHalhpYlVEYlUrc1BTczRyaDB5Yk9tbjdYVERFYjA1?=
 =?utf-8?B?ZmZJRlJZMEM4S1lMdUNQY1RJNk9Ycjl2andMeHhyQXdPZkVhMWlMN2lJYzN6?=
 =?utf-8?B?U1BNWE0waHJLMWNrOVM1MGJTYlhNejBOU0c0ekR4ME9mSWRreEFDSUVxODRq?=
 =?utf-8?B?MnZoMTdsWko4Yk90L01wOUpSUFB3enJBQTlPSldkNDBKaFFkYzNYY0lTTGF6?=
 =?utf-8?B?a3pWaDk1a2dRdGF2V0hwOG10Nkw2eDV0aUZlT1BXRExSaE5POW1uck1TRi9j?=
 =?utf-8?B?UjFLOHZlN3U3cWZJbHRZTDNCR29BVm1LWnJUMnBsN1NDcDRDOEJ5MTloTzNE?=
 =?utf-8?B?Z1ZQb1FScGNZdzJWZDBqZDdIQUwyVU1yQ0haZ2o0RFl4ZDh1Q3dYUlh5blFP?=
 =?utf-8?B?am8xUmxlVWpnY1ZNMmZacnhLVlc0bkpjZklOWXZFUzl2aUYxN1YzUnJLSGNI?=
 =?utf-8?B?b3ROLzhwZzVZcWZ0MkJMQ1RTK1BpMWMrRXk2K1cxOE9SNC9uRnRiWE9DaTRl?=
 =?utf-8?B?SlB2ZHFTSHJ1ME1ZRU9lTjhUTkRXOGs0bVMzZHRidHdEYlJndzBtZUQwR0cw?=
 =?utf-8?B?MkV6U29lUGxINFl0RDZnZjNvMjV2VnVRT3d6YnpKU2dlaE1lYmZJa3pJWExw?=
 =?utf-8?B?ckUvcUwwZnRRQlI3MFZaM3Y1cFEwSUJwYUx4enAwUHpoUE91eWN3aFNJTjU3?=
 =?utf-8?B?OTBkVm5DZjBaZS9Na1YydDRFaXJNZGoyayt1SEY4djdJU3Z4SzhYbmQ4b2Y3?=
 =?utf-8?B?N3ZXcDBDWHljaEcvcWVNRUpjT2tIakVCRDJmMWJNZkl5KzlKOGhYWGNGMDF2?=
 =?utf-8?B?YTBKVkp5NjZVd1M5SWZ4ODNKUDhudFhaSlNwNGZ4Q24yOTBqd252Nkk5WVZJ?=
 =?utf-8?B?OXZzOG5rbVNpcXBNYXZFMGpRKysrbVd6QThPenZmNUlTcFUwY3ZOY3pJaVR5?=
 =?utf-8?B?UTc0L05zbE83cE5LL1VWRk9PdnphaVJYRTdxR1VVZ2ZtWGwrNUk1cW5wMXMy?=
 =?utf-8?B?aFdKUnN2QVllNnVSRUh1aHFIbTN0cXkwWUllbjByRmtJcGFPekgxaHVpVGNU?=
 =?utf-8?B?aEsxQzR6OUxWdGFITVk0enhjUThyTnNLbzJmZ2drOEhwTXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmsxQzYwc0tlZGdnczh2enEvc25FQ0RIdUJSWnVDOHR0UG1HL3VBNVBjVjRv?=
 =?utf-8?B?U1dnb2MzUk9HNjFBelBHRXZlZWVseDJ2bmJMUktYdEtUQzJrdTJnS2ppd2Y0?=
 =?utf-8?B?WlVKZnBSZmNidmpOaDhoRmVwWkpxY21zZmdicnZTL0dwZSsxZHFLWEpJTzVw?=
 =?utf-8?B?aW91Vit4SFdPanUvdmRheU5abzM1eVlHN0hXVTlRTDl6cVRybjFhc2grbWdx?=
 =?utf-8?B?bkd3LzhLVHVMeG1BMkxpQTRRWlRVbUg0bkNvUjV0dUlPK3RZUEQ5WHd0Kys0?=
 =?utf-8?B?OVhsd0hNckcwZzZqRHIvejlyTXZLQmxBZHRLZTY0UnVVak5KYTh3RDYyd3k4?=
 =?utf-8?B?YUJUeUV1SFJnTFJoOVYwTXVDcnBSVURibW53M01LNXJCSUpLTDhIL2dTQ21P?=
 =?utf-8?B?bmNTK0h4RlYzOFgxUlA4TFBzdCtoWHV0YlVwRWhjOEVod0kwN09kZ1lzUnJz?=
 =?utf-8?B?d0M0TWpncmQ1VDlvR0lTZ1ZFOVBSc1Y4OTBQbkRQSkxxekhzbDMvZTlNczVD?=
 =?utf-8?B?c1pjN3QvekxxRVZkWW93MXltNk9UbFpyK3lxdDBpYlN4WG51aDFhSTJzR0pv?=
 =?utf-8?B?c3IyUHU4dnpyVU04eGFRWjI5ZWJneWswTnhhcU9qd1hmUkcyRzBhKzBBb3dK?=
 =?utf-8?B?RTU2UHBla3hndXRTYkc5TkJPRjFMdnZ5cEdIdmJud0NwVHEvdWFXdFpzRDVU?=
 =?utf-8?B?MTlWaVNJTmZ0S0N1djdlZnVIVkg5M0txbjlXWFlaUllzb29XS29hU0F1NnBW?=
 =?utf-8?B?RGpXRGpaN1JNWFRHNWVnQk5ySkdvOTEyRmFtT2JjZVpaM2ljelNXRTFESllT?=
 =?utf-8?B?a2s3Rlo0YXlTbHZoOGhpbHU2aHk4SzY2aW9Ic2JsRVVRMVBLUFlVWHB1TVVi?=
 =?utf-8?B?UjNWaXhFdUdlYzV3OGdING9OL0J3eDJpK1orcWpCNW9HZHVMVTZRKzFTekpo?=
 =?utf-8?B?NUU5NDNIZW82Vm1ocHR5TGN6RXFwcndWamYzTUxkT1FyYVJQUCt3dklZM3FX?=
 =?utf-8?B?R3NmUWxkOGU3aHcvSXhPaWJaNjI2UHF2YVFlNjVxbXM1VFozWEFhV3NUQThp?=
 =?utf-8?B?UUpscmExWHExQ2Y5U2YyeTdGbmpLNUVGZ1NBdThrZ1o0UU42bzZSOThUcEth?=
 =?utf-8?B?Ynh0QW1KMllnYmQ5VjVzNXhkei83UEhTdDhzS1M4TU9PbGliVUxrclFsRHdX?=
 =?utf-8?B?Z3ZrMzBvK05rVHk3MmloY01NdEI0aWlTSzdaeGtqMFR1QklPdGk0K1dCL2hS?=
 =?utf-8?B?a0RmVGMzdi9TZTltcGd0VFdROWkvSWlhbmZXOG42TWhZblBQdWZiRzBWc0tB?=
 =?utf-8?B?WlA3ZVE0TUc3ZWFUNmNScHJldE1zR3BXd3lObEUvdzdqeUdheXZiMDdSU2hV?=
 =?utf-8?B?WlpudnpqTXlRaFpQVUZrUkt1SVBOOXV5a2FlLy9UeUUvSEcvYXoyV00rbnB2?=
 =?utf-8?B?R0E1M0UyTDZIMXlCOWRDT3djd04zYzk5V0w5YjJoYk9Bdk54SUVneWM2OHFi?=
 =?utf-8?B?Ylg5d1UvRXFEclRRUU9IczFiM0gwWmozOGdPYzI1VVlSNnEvSXVwZGhWQTc3?=
 =?utf-8?B?RExVbUpnMjBiWHdTeW5YbEdsRzdFU1BHWUhoWmFyL3lHYUpXQ2g1RElLMlAy?=
 =?utf-8?B?R1ZsNkQ5RUh5ckUwRCs3UTZ3UkJvbkhqTjAzWWxIbGFPcXA1b2J0OHZmSW9L?=
 =?utf-8?B?aTFONXlRSVlhcXlWc1lCRU4rd2FuTTRkaHpsQy9paWkyWktIOW1qQ25zcnJ3?=
 =?utf-8?B?THdsYVhXdHkrWTN6TlFETjYyNDVQOWEyc2JacGVDUDh5dDFNOEtpanBqMTlC?=
 =?utf-8?B?NjlFRGN3TnFOanQwNVBPNFFySjJBc0t3N1FRY3Yxd2FKVGtsWHo0OTFVSytT?=
 =?utf-8?B?RWRKZzdsQ3VIQlhFK2J5SHUyTFlTdElQMmtQQjRuVk8wOUNFa3B2dVBrQVZk?=
 =?utf-8?B?ODltZ1JVQS8xNk1PVlp2SzhwaVY1YW5iUEREbFo5NElTMW5TYWlyMGt2TUxa?=
 =?utf-8?B?bkp5cnZLeUpCMEoxNk95Z1dnOTIvMXBPa3dnNlQ4UXZNOHNtNktiMG5zaWR5?=
 =?utf-8?B?YysyN08vcFpoK3ZSR2hnZzl1OGt0M01LMkJObDhYaDY3M09ReWxTL3dNUHEr?=
 =?utf-8?Q?O1SKyZo0EFDhK7ROmc5fpLP7J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f682995-356a-45db-8bd0-08dddc3489c8
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 19:47:16.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXJI+PxwuhUhEYEQ5MIQNywtEKRa8aRmkCahlL1htvvHAXNPBKBYdTv2/t65JBgqx8PI5iNgF5XzZ4bnc99q4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864

The mgx4u is a BMC for a granite rapids based motherboard
that connects to a cx8 switchboard.

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts    | 1078 ++++++++++++++++++++
 2 files changed, 1079 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index b3170fdd30969b5b064c5333aea136d3abfcbe72..f150ed0f2e48edb804b0588ef098edb3282b6292 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -51,6 +51,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-lenovo-hr855xg2.dtb \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
+	aspeed-bmc-nvidia-mgx4u.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts
new file mode 100644
index 0000000000000000000000000000000000000000..beaf68d5b4bd73ec219a0d2d400f93cf05b0d34f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-mgx4u.dts
@@ -0,0 +1,1078 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "MGX4U";
+	compatible = "nvidia,mgx4u", "aspeed,ast2600";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+
+		i2c16 = &i2c5_mux_0;
+		i2c17 = &i2c5_mux_1;
+		i2c18 = &i2c5_mux_2;
+		i2c19 = &i2c5_mux_3;
+		i2c20 = &i2c5_mux_4;
+		i2c21 = &i2c5_mux_5;
+		i2c22 = &i2c5_mux_6;
+		i2c23 = &i2c5_mux_7;
+
+		i2c24 = &i2c6_mux_0;
+		i2c25 = &i2c6_mux_1;
+		i2c26 = &i2c6_mux_2;
+		i2c27 = &i2c6_mux_3;
+		i2c28 = &i2c6_mux_4;
+		i2c29 = &i2c6_mux_5;
+		i2c30 = &i2c6_mux_6;
+		i2c31 = &i2c6_mux_7;
+
+		i2c32 = &i2c7_1_mux_0;
+		i2c33 = &i2c7_1_mux_1;
+		i2c35 = &i2c7_1_mux_2;
+		i2c36 = &i2c7_1_mux_3;
+		i2c37 = &i2c7_mux_0;
+		i2c38 = &i2c7_mux_1;
+		i2c39 = &i2c7_mux_2;
+		i2c40 = &i2c7_mux_3;
+		i2c41 = &i2c7_mux_4;
+		i2c42 = &i2c7_mux_5;
+		i2c43 = &i2c7_mux_6;
+		i2c44 = &i2c7_mux_7;
+
+		i2c45 = &i2c0_mux_0;
+		i2c46 = &i2c0_mux_1;
+		i2c47 = &i2c0_mux_2;
+		i2c48 = &i2c0_mux_3;
+		i2c49 = &i2c0_mux_4;
+		i2c50 = &i2c0_mux_5;
+		i2c51 = &i2c0_mux_6;
+		i2c52 = &i2c0_mux_7;
+
+		i2c53 = &i2c0_1_mux_0;
+		i2c54 = &i2c0_1_mux_1;
+		i2c55 = &i2c0_1_mux_2;
+		i2c56 = &i2c0_1_mux_3;
+		i2c57 = &i2c0_1_mux_4;
+		i2c58 = &i2c0_1_mux_5;
+		i2c59 = &i2c0_1_mux_6;
+		i2c60 = &i2c0_1_mux_7;
+
+		i2c61 = &i2c3_mux_6;
+		i2c62 = &i2c3_mux_7;
+
+		i2c63 = &i2c9_mux_0;
+		i2c64 = &i2c9_mux_1;
+		i2c65 = &i2c9_mux_2;
+		i2c66 = &i2c9_mux_3;
+		i2c67 = &i2c9_mux_4;
+		i2c68 = &i2c9_mux_5;
+		i2c69 = &i2c9_mux_6;
+		i2c70 = &i2c9_mux_7;
+	};
+
+	chosen {
+		bootargs = "console=ttyS4,115200n8";
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
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	non-removable;
+	bus-width = <4>;
+	max-frequency = <100000000>;
+	clk-phase-mmc-hs200 = <9>, <225>;
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-128.dtsi"
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
+	/*A0-A7*/ "","","","","","","","",
+	/*B0-B7*/ "","","","","","","","RST_BMC_8211F_N",
+	/*C0-C7*/ "","","","","","","","",
+	/*D0-D7*/ "","","","","","","","",
+	/*E0-E7*/ "","","","","","","","",
+	/*F0-F7*/ "","RST_BIOSROM_1_BMC_N","","RST_SPI_PFRM1_R_N","","","SPI_BIOS_MUX_SEL","",
+	/*G0-G7*/ "","","","","","","","",
+	/*H0-H7*/ "","","","","","","","",
+	/*I0-I7*/ "","","","","","","","",
+	/*J0-J7*/ "","","","","","","","",
+	/*K0-K7*/ "","","","","","","","",
+	/*L0-L7*/ "","","","","","","","",
+	/*M0-M7*/ "","","","","","","","",
+	/*N0-N7*/ "","","","","","","","",
+	/*O0-O7*/ "","","","","","","","",
+	/*P0-P7*/ "","","","","","","","",
+	/*Q0-Q7*/ "","","","","","","","",
+	/*R0-R7*/ "","","","","","","","",
+	/*S0-S7*/ "","","","","","","","",
+	/*T0-T7*/ "","","","","","","","",
+	/*U0-U7*/ "","","","","","","","",
+	/*V0-V7*/ "","","SCM_HPM_STBY_RST_N","","SCM_HPM_STBY_EN","","","",
+	/*W0-W7*/ "","","","","","","","",
+	/*X0-X7*/ "","","","","","","","",
+	/*Y0-Y7*/ "","","","","","","","",
+	/*Z0-Z7*/ "","","","","","","","";
+	status = "okay";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "","","","","","","","",
+	/*18B0-18B7*/ "","","","","SW_MAIN_EN","HOST_GLOBAL_WP_N","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","";
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	i2c-mux@73 {
+		compatible = "nxp,pca9548";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c0_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			eeprom@51 {
+				compatible = "atmel,24c02";
+				reg = <0x51>;
+			};
+		};
+
+		i2c0_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			tmp75@4c {
+				compatible = "ti,tmp75";
+				reg = <0x4c>;
+			};
+		};
+
+		i2c0_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c0_1_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c0_1_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@72 {
+		compatible = "nxp,pca9548";
+		reg = <0x72>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c3_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	i2c-mux@77 {
+		compatible = "nxp,pca9548";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c6 {
+	status = "okay";
+
+	i2c-mux@70 {
+		reg = <0x70>;
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c6_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			tmp75@4a {
+				compatible = "ti,tmp75";
+				reg = <0x4a>;
+			};
+
+			tmp75@4b {
+				compatible = "ti,tmp75";
+				reg = <0x4b>;
+			};
+
+			eeprom@51 {
+				compatible = "atmel,24c64";
+				reg = <0x51>;
+				pagesize = <32>;
+			};
+		};
+
+		i2c6_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/*fan controller 0*/
+			max31790@20 {
+				compatible = "maxim,max31790";
+				reg = <0x20>;
+			};
+
+			/*fan controller 1*/
+			max31790@21 {
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+
+			hpmfanio: pca9555@27 {
+				compatible = "nxp,pca9555";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <11 0>;
+				gpio-line-names =
+						"HPM_FAN1_INSTALL", "HPM_FAN2_INSTALL",
+						"HPM_FAN3_INSTALL", "HPM_FAN4_INSTALL",
+						"HPM_FAN5_INSTALL", "",
+						"","";
+			};
+		 };
+
+		 i2c6_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		 };
+
+		 i2c6_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* 4056 fan board_EEPROM*/
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+
+			/*fan controller 0*/
+			max31790@20 {
+				compatible = "maxim,max31790";
+				reg = <0x20>;
+			};
+			/*fan controller 1*/
+			max31790@21 {
+				compatible = "maxim,max31790";
+				reg = <0x21>;
+			};
+
+			gpufanio: pca9555@27 {
+				compatible = "nxp,pca9555";
+				reg = <0x27>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&gpio0>;
+				interrupts = <11 0>;
+				gpio-line-names =
+						"GPU_FAN1_INSTALL", "GPU_FAN2_INSTALL",
+						"GPU_FAN3_INSTALL", "GPU_FAN4_INSTALL",
+						"GPU_FAN5_INSTALL", "",
+						"","";
+			};
+		 };
+
+		i2c6_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* IO board EEPROM*/
+			eeprom@57 {
+				compatible = "atmel,24c64";
+				reg = <0x57>;
+				pagesize = <32>;
+			};
+		};
+
+		i2c6_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c6_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c6_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c7 {
+	multi-master;
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c7_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			i2c-mux@71 {
+				compatible = "nxp,pca9545";
+				reg = <0x71>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				i2c7_1_mux_0: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c7_1_mux_1: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					eeprom@55 {
+						compatible = "atmel,24c64";
+						reg = <0x55>;
+						pagesize = <32>;
+					};
+
+					eeprom@50 {
+						compatible = "atmel,24c02";
+						reg = <0x50>;
+						pagesize = <32>;
+					};
+
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+						pagesize = <32>;
+					};
+				};
+
+				i2c7_1_mux_2: i2c@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c7_1_mux_3: i2c@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+		};
+
+		i2c7_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* XDPE19284B - CPU0 PVCCIN VR */
+			xdpe152c4@60 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x60>;
+			};
+
+			/* XDPE19284B - CPU0 PVCCFA EHV FIVRA / PVCCINF_VR*/
+			xdpe152c4@62 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x62>;
+			};
+
+			/* XDPE19284B - CPU0 PVCCA EHV PVCCIN VR */
+			xdpe152c4@74 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x74>;
+			};
+
+			/* XDPE19284B - CPU0 PVVCCD0 & D1 VR */
+			xdpe152c4@76 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x76>;
+			};
+		};
+
+		i2c7_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* XDPE19284B - CPU1 PVCCIN VR */
+			xdpe152c4@60 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x60>;
+			};
+
+			/* XDPE19284B - CPU1 PVCCFA EHV FIVRA / PVCCINF_VR*/
+			xdpe152c4@62 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x62>;
+			};
+
+			/* XDPE19284B - CPU1 PVCCA EHV PVCCIN VR */
+			xdpe152c4@74 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x74>;
+			};
+
+			/* XDPE19284B - CPU1 PVVCCD0 & D1 VR */
+			xdpe152c4@76 {
+				compatible = "infineon,xdpe152c4";
+				reg = <0x76>;
+			};
+		};
+
+		i2c7_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c7_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+};
+
+&i2c9 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c9_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-north.dtsi"
+		};
+
+		i2c9_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-south.dtsi"
+		};
+
+		i2c9_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-north.dtsi"
+		};
+
+		i2c9_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-south.dtsi"
+		};
+
+		i2c9_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-north.dtsi"
+		};
+
+		i2c9_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-south.dtsi"
+		};
+
+		i2c9_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-north.dtsi"
+		};
+
+		i2c9_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+#include "nvidia-mgx-cx8-switch-south.dtsi"
+		};
+	};
+};
+
+&i2c10 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c10_mux_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_4: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_5: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_6: i2c@6 {
+			reg = <6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c10_mux_7: i2c@7 {
+			reg = <7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	rtc@6f {
+		compatible = "nuvoton,nct3018y";
+		reg = <0x6f>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+};
+
+&mdio3 {
+	status = "okay";
+
+	ethphy3: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac2 {
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+	status = "okay";
+};
+
+&mac3 {
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+	status = "okay";
+};
+
+&peci0 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&sdc {
+	status = "okay";
+};
+
+&sgpiom0 {
+	ngpios = <128>;
+	gpio-line-names =
+		"","LED_PORT80_0_N",
+		"","LED_PORT80_1_N",
+		"","LED_PORT80_2_N",
+		"","LED_PORT80_3_N",
+		"","LED_PORT80_4_N",
+		"","LED_PORT80_5_N",
+		"","LED_PORT80_6_N",
+		"","LED_PORT80_7_N",
+		"","CPLD_JTAG_OE_R_N",
+		"","RST_PE_SLOT_I2C_MUX_N",
+		"","ASSERT_CPU0_PROCHOT_N",
+		"","ASSERT_CPU1_PROCHOT_N",
+		"","BMC_CPU0_NMI_OUT_N",
+		"","BMC_CPU1_NMI_OUT_N",
+		"","CPLD_PWRBRK_N",
+		"","SPD_SWITCH_CTRL_N",
+		"","COM_DBG_MODE",
+		"","RST_CPU0_RTCRST_PLD","",
+		"EN_MON_VBAT","","BMC_RST_BTN_OUT",
+		"","BMC_PWR_BTN_OUT",
+		"","BMC_WAKE",
+		"","CPU_FRBK_OUT",
+		"","CPU0_BMC_INIT",
+		"","CPU1_BMC_INIT",
+		"","NCSI_BMC_CLK_EN",
+		"","NCSI_OCP_CLK_EN",
+		"","IRQ_CPU0_TPM",
+		"","UART_HPM_MUX",
+		"","DEBUG_BIT_0","","DEBUG_BIT_1",
+		"","DEBUG_BIT_2",
+		"FAN_4056_BOARD_ID_0","DEBUG_BIT_3",
+		"FAN_4056_BOARD_ID_1","DEBUG_BIT_4",
+		"FAN_4056_BOARD_ID_2","DEBUG_BIT_5",
+		"FAN_4056_BOARD_ID_3","DEBUG_BIT_6",
+		"FAN_8080_BOARD_ID_0","DEBUG_BIT_7",
+		"FAN_8080_BOARD_ID_1","LED_BMC_HBLED_CPLD_N",
+		"FAN_8080_BOARD_ID_2","LED_SYS_ALERT_CPLD",
+		"FAN_8080_BOARD_ID_3","LED_PWR_YEL_CPLD",
+		"FAN1_FRONT_TOP_INSTALL","",
+		"FAN2_FRONT_TOP_INSTALL","",
+		"FAN3_FRONT_TOP_INSTALL","",
+		"FAN4_FRONT_TOP_INSTALL","",
+		"FAN5_FRONT_TOP_INSTALL","",
+		"","",
+		"","",
+		"","",
+		"FAN9_REAR_INSTALL","",
+		"FAN_FRONT_SW0_FAIL","",
+		"FAN_REAR_SW0_FAIL","",
+		"FAN1_FRONT_BOT_INSTALL","",
+		"FAN2_FRONT_BOT_INSTALL","LED_UID_N",
+		"FAN3_FRONT_BOT_INSTALL","",
+		"FAN4_FRONT_BOT_INSTALL","",
+		"FAN5_FRONT_BOT_INSTALL","SPI_MUX3_EN",
+		"FAN1_REAR_INSTALL","SPI_MUX2_EN",
+		"FAN2_REAR_INSTALL","SPI_MUX1_EN",
+		"FAN3_REAR_INSTALL","SPI_MUX3_SEL",
+		"FAN4_REAR_INSTALL","SPI_MUX2_SEL",
+		"FAN5_REAR_INSTALL","SPI_MUX1_SEL",
+		"FAN6_REAR_INSTALL","PDB_RST",
+		"FAN7_REAR_INSTALL","PRE_STANDBY_DROP",
+		"FAN8_REAR_INSTALL","",
+		"MLB_BRD_SKU_ID0","",
+		"MLB_BRD_SKU_ID1","",
+		"MLB_BRD_SKU_ID2","",
+		"MLB_BRD_SKU_ID3","",
+		"MLB_BRD_REV_ID0","",
+		"MLB_BRD_REV_ID1","",
+		"M2_1_PRESENT","",
+		"M2_2_PRESENT","",
+		"M2_1_ALERT","",
+		"PASSWORD_CLEAR","",
+		"IRQ_PSYS_CRIT","",
+		"LEAKAGE_MONITOR_ALERT","",
+		"M2_2_ALERT","",
+		"RST_BTN","",
+		"PWR_BTN","",
+		"","",
+		"CPU1_MEM_VRHOT","",
+		"CPU0_MEM_VRHOT","",
+		"CPU1_VRHOT","",
+		"CPU0_VRHOT","",
+		"RST_PLTRST_MONITOR","",
+		"CPU_SLP_S3","",
+		"TPM_PRSNT","",
+		"HPM_HMC_PCIE_PERST","",
+		"CPU1_THERMTRIP","",
+		"CPU0_THERMTRIP","",
+		"CPU1_PROCHOT_CPLD","",
+		"CPU0_PROCHOT_CPLD","",
+		"CPU1_MEMTRIP","",
+		"CPU0_MEMTRIP","",
+		"CPU0_MEMHOT","",
+		"CPU1_MEMHOT","",
+		"CPU_ERR2","",
+		"CPU_ERR1","",
+		"CPU_ERR0","",
+		"CPU_CATERR","",
+		"CPU_RMCA","",
+		"","",
+		"CPU1_MON_FAIL","",
+		"CPU0_MON_FAIL","",
+		"PUS4_PRSNT_N","",
+		"PUS5_PRSNT_N","",
+		"PUS6_PRSNT_N","",
+		"PUS7_PRSNT_N","",
+		"PUS8_PRSNT_N","",
+		"PUS9_PRSNT_N","",
+		"PUS10_PRSNT_N","",
+		"PUS11_PRSNT_N","",
+		"PWRGD_CPU1_S0_PWROK","",
+		"PWRGD_CPU0_S0_PWROK","",
+		"","",
+		"PSU_SMBUS_ALERT_N","",
+		"PSU0_PRSNT_N","",
+		"PSU1_PRSNT_N","",
+		"PUS2_PRSNT_N","",
+		"PUS3_PRSNT_N","",
+		"CPU0_PRSNT_N","",
+		"CPU1_PRSNT_N","",
+		"CPU0_PWR_GOOD","",
+		"CPU1_PWR_GOOD","",
+		"PGD_SYS_PWROK","",
+		"BIOS_POST_CMPLT_N","",
+		"CPU0_CD_INIT_ERROR","",
+		"CPU1_CD_INIT_ERROR","";
+	status = "okay";
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	fmc-spi-user-mode;
+	status = "okay";
+
+	flash@0 {
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <2>;
+		status = "okay";
+	};
+};
+
+&syscon {
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
+&uart_routing {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};

-- 
2.34.1


