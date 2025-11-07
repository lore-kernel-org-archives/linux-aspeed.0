Return-Path: <linux-aspeed+bounces-2829-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0827BCCF9F8
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 22:46:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3DgV0Svmz30Qk;
	Sat,  8 Nov 2025 09:46:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c112::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762555573;
	cv=pass; b=KpFXYpLcC9Rnfyu8wGjErkDO7GPmfj//nCtktMoZ3e8X/A2ua7cyuVKTnIR6b5zDOBkckJlfvA4L6jIs1W7MSyU7vflEfczxeQ2QjvWqV/Ex/e/JhNWV0PYTNylRO4zp0JdMOMdiIsPBN8a6s2irBHpBAwqlrMyA1+IPGHQ190V0fggWD01dlIOWBBesVaMsmA1MHUrGYWX4FrqC/IfT7NP8xaXd279SZ9JP2N2+M0ozxax1pFqIUehbDRoTAbUTkQMRtiqoXtKJdmKPAC0SJxuN3+Hr6eKGfjdMSmWx3gIuMhDkXq5ZkTF8I2KCSCZRYYM1j6hCsR74wT5q0/tTTg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762555573; c=relaxed/relaxed;
	bh=KiZHBXtiA5QfhbspBNg2c5vxDIC4kRhsDzLFoD0FOB0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=emoNQTF7YFgLh9VHXQt7hMpC4EuYiErKa9eW/sEXrTFO1uHOT3cknVNj0//NIcTjDdUuWcRWyN9rGUFV4X1y7fS43qIgKwMte0noNnc8S+6VoGjGHIHRXRliecXwftIk5yskbjO8fDAd87kpQ9xyk6QPg7JiXL4YxKKmFc8OvXU9PpL8z091qhipoU7cyE6v6daNmy5wTF6LvPBvk9Q7PXGaTPAoMCKIikkZiwPFX9fJSDgy2AKV1Gx8wwg9F12iHlNRugJi0isupA0R8EVV8jPa5qhsLZGwHM67QVaXjmSVsRGdOx4tywCyFUG+SS4TQbFKY91WeSUf2Rq//DJDMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=meD4bCbV; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=meD4bCbV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c112::5; helo=cy7pr03cu001.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c112::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d3DgP4GXYz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Sat,  8 Nov 2025 09:46:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5E+2jWk5s/Ezfy4PKXT9rIUfTStwAv6JGv/oeUvzqJZrjhYagfbnskybXtcHzsclom5lf4nqd3KF8Ffc6Wh0c/a0aG2Zd4gdBHSHTzTBVv4lIzZDeWYJrud3LD1qXQLdRwjVetvqaPO1hGnDuiDugIyO+qp6a4jghpnC+svdXq204VZiHpE3NPtHQLYAKbpO/vt29V1dBPjk3DlBcB+LSs0WZYSL13znKGv1YXBfd7teuP0gVXAPVwri4DPMjO89LkFyZkHbP8T6S8TRy0l1RQhEoGltBEgnG+5E4KkKxiVzDOmnReb/iaN+ECKiFfZZBCH/Og45uOjAFde+FN+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiZHBXtiA5QfhbspBNg2c5vxDIC4kRhsDzLFoD0FOB0=;
 b=p6VwEQNDVU0H1/ymWR+0OmJ0Bk4CK/Z5C4jaBjw4Y55em4+KnbEKLcDJfEhxd2+V3nt8lDUtcEB4qR6hDAPUMb09wbC+dIGF6FSlFBSu6QDII7oiCsYw6eycd3Puq1JX+KOyIWTIgCf3Ea8wU4mGBQwTtzZsjESX+IZEqJqBqtZkFspS03efCtR6oi1QHKJuDrGHUt7sy6I9pN3KQ6NeKZiudOpn26wx/rPzuEqXYlHGCy/1CFp++fd895yTslHn/Y8wjOWPhL55MLu/Q6jBHr6v0URfNIT3FnwaMYbN9NWwRq0wOvtCxVWAjIjCwHErmh+jPZLIkx1MTVIBYbQiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiZHBXtiA5QfhbspBNg2c5vxDIC4kRhsDzLFoD0FOB0=;
 b=meD4bCbVRJOBKyKJEXlLGoqV6fli+ylbUnRVDcUt9UADDiopa8ci0eTNRxrsp9DuAdRcGqOUiRJU1qAZFsZJz4b/jpRVANZlILx69WlSqTPUrTBYUKh7VMoncqbXNRf6L1D3e7vjSU9ovVFi1kWhj596+uxh55dCbz4ZbHF/P3Rjb+5FOWaJt0hDAk8m5GNU/LJRBeNFuhOaKP+d/tBFQHACeBMwTmM7zI6g39BUYDfLRsFs20KQ2gG8YRD1WSmJ4+hbf5zwQ6a3sMGaNYPatFzxNJZRWgWG0Z8nlaUqKzfCkMy/9Uvm4bf+GX3ebNDifvawIHGyrqEDmaIy/oOqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by SJ0PR12MB6806.namprd12.prod.outlook.com
 (2603:10b6:a03:478::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Fri, 7 Nov
 2025 22:45:41 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::7816:ec9f:a1fe:e5c9%6]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 22:45:41 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH v2 0/2] Add device tree for Nvidia BMC msx4 cx8 switchboard
Date: Fri, 07 Nov 2025 14:45:35 -0800
Message-Id: <20251107-msx1_devicetree-v2-0-6e36eb878db2@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJB2DmkC/2WNQQrCMBBFr1JmbWQmUBpdeQ8pEpKJnUVTSUqol
 NzdWNzJrN7n/zc7ZE7CGa7dDomLZFliA33qwE02PlmJbwwadY8XNGrOGz18azpeE7MabNCOgqP
 eI7TVK3GQ7TDex8aT5HVJ7+NBoW/6c9G/q5BqZ7zDgVETmVss4sWe3TLDWGv9ADmPmR2vAAAA
X-Change-ID: 20250908-msx1_devicetree-7af2c1fc15d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762555539; l=1254;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=/OeNY2LkEH34nFu+PJTbUNjuEfU/oQOggTvLtjdo6yY=;
 b=BuHaeDZgm1ZoYLHh1BacfOSJ55tJEWZGWzTB03m7DNQyo4UPSWj56V/YuOmoqc8a0hkw5DkDh
 VY4swMbDUbsDWXWMieCh3KcAEE5DTX4/IlyXmHqc8fi6QZXh0NHuctu
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 39647cd5-cbad-44ce-3c9c-08de1e4f60ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkxyZml0aklMRlI3ZGxXN3dWeGdMTWdLVDBVTHhvTUcyMDYyaDdRZ2syUFE1?=
 =?utf-8?B?eHpiT2xLRlpRaSsyUE9JNVcrZWxWb2VrcmZsc0hSUkZqNUxRTEkyWmc1R3N5?=
 =?utf-8?B?Y0xyZHlqOXF6OXE4aFBlVVJKMmtITGxpSm1QNmdYdDJTVnZnTGlZVHI1eFpF?=
 =?utf-8?B?MGxCWHdPejZCUjBJRlQwYUZJOGg3bEEvejFwc3doeUo4QnpRdHhSWm9UYlAx?=
 =?utf-8?B?VUwyM2Y3dVFUWnl3YjlnOWJxWUJmSmt3Zi9EWFVRRkxFM3RNNmpOUUxQeTl1?=
 =?utf-8?B?RTNPN0RSNTB5YjFFNHJOMGVrU0dPTUo2U2dOU3Z1MHZwR2JZWlBUbmEvM25G?=
 =?utf-8?B?aUtJLzRjMmlwVDRFVko5V1NFYnNQTXNWWTRXRE9ORmNrK09md1JQb09xM21h?=
 =?utf-8?B?WDAvWngyWkhILzNvYXZRb2Vzbk1VL2x1aGU4UmNuMlFCK0c2OGVOQU5KZ3hh?=
 =?utf-8?B?d0d2eWRZSjk4bDl3UXFpQUsvYWszWkdYY1NyditDVjJ4Ti9TK3A5dExXNTBK?=
 =?utf-8?B?QWNPdkl2dkR0VVVEOUxvbVpHWVJjVTVPYncyN2M3czcrZWxoZWpraElTcUNH?=
 =?utf-8?B?ZkxzL1dJK0UrTWp5MHZhYVJuL2FIMDB2aDIwRVBzMC9EYUh3VWY4dDV1ZzZX?=
 =?utf-8?B?OE5vNXo3Uy9vTWcreU4zM01pTURRdmM1NjFlNWt3OVBTSkkreHE2MTgrTDVk?=
 =?utf-8?B?TU5yN3A4SXNGQlJ0RjlPM0FXSXdRRVd1NGNBN3hNSWNaS0t2alVYY3RXb3gw?=
 =?utf-8?B?enlMT0FlSHRycm5VSVRHOUZkNThLNGorT2pzSnVubGEybmUzbHFCV25oOVBO?=
 =?utf-8?B?Zm1helVxLy90ZFJNNTdabjBEQ1VJTVh1NFBYSlE0ckJISStYOXQvZVprdFN5?=
 =?utf-8?B?UmRGQjZmM3UrbEZ5NEIrVUExRGVNODU4YWNxM1FrV1lPY0huOEFtbE4vcmFo?=
 =?utf-8?B?dWZJRzhtUzhoR3lGYkE4NkdsNDNYQTZKQWlYNGNVWWlHWExnV284ZytKaHRI?=
 =?utf-8?B?aTFkWUpkTWpIK2Z5dngwcHlNVFJZTnRITWZ1Um00U3UxZHZGUEJnY052RTBT?=
 =?utf-8?B?NUxCYzh3TlJtTTlQbkNXS1M2N2l5c0l6c1JCRUtTb2NPR3B6M0d6VlV0QVVD?=
 =?utf-8?B?andRYlJpMy9lNU1wZU5GWWJTKzAwSVhmM0M2eTZsNjJ5a1hBQUgxeU5IbTVH?=
 =?utf-8?B?ZDFFRUVEZ3pEMitDVjJFYnFxZXFkaFBsSHZpSEJObHFnay9aTGxLbFdNYVFU?=
 =?utf-8?B?RzZaelhpUnIwSjl0OGVobG16U1UvUnd0SnY1MWhjN1VqYnQ0RzF1WnRUU2Er?=
 =?utf-8?B?L3VrVVh2VHdrSkkxRDVDZERzTWtDR3Bua0ttYWFoTkdkalFhNmswMXBsa2Va?=
 =?utf-8?B?cTBsaytDdHU5djB5QkpJVXhWNlpnOXk1QjlrMndkOXYyZWNwMGpVMVNkb3VT?=
 =?utf-8?B?Ni9FQmpjMEszZ0EycTlTVkF3ZmJuSFhRdUowUmRKMXJZSGtiWk1ob3YxN2pJ?=
 =?utf-8?B?VldkTExtNC9pZDVVVitYUm0vZkZSN0ovL3BjbG9xUUd6U3MyZnJzZlAvL0kr?=
 =?utf-8?B?OEk1OTlQc1BZMWhPdDNMZjBKZ2ZYc3dsdkhCaXdMdTdNS0J2RTVvelA4OUZw?=
 =?utf-8?B?K1lMeG9JaTVoN1cvd1lnVW81SEZYbklacmNVK3c2NDc2cWVwcDNRUGhUVnMr?=
 =?utf-8?B?Q2hhdTUvajBOSDRsVW91MlVKRGhIRUpLWkVwTXE3SGdmSTFIWXFwUTBzVjY5?=
 =?utf-8?B?bnFGL3pwdm9UQUdtanE2SVl1T0dxNlZKMDVWNVJoZWQwWUpHeWJuUU9VNFcy?=
 =?utf-8?B?OFc5RmpKMDZNWGovY05Ganh4aGZ5TGFvaVorVXRxNklMY1hCZnRIMmNlaW9z?=
 =?utf-8?B?SVg1akhXYWgwQmRVaEh6NERHMlVZL3ZYTytZa0NDeEtXMnJKckxwWUFUZjJV?=
 =?utf-8?Q?HxrwbkB7AWhgp+xoDzx+1soe8i0MtcBD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDgya2NjaTNPY3pwczViMnhmZEpjZW9qOVhadzYrb08xV25od1JNbFBkNlNR?=
 =?utf-8?B?SmtOQ2hQZHJVUDJFbTlFcDdpclFyRExFK0R2M2l4Y2dNUkFEVXhld2VOQVhp?=
 =?utf-8?B?R2ZHMmJtNGw4N1NVMjdvYkNIK0ZiaWVReng3NU53c3A0U3dEZlJBNTdjaXBX?=
 =?utf-8?B?elI5bjVzTFhiY001bXJKWm9XKzhpNHdKUFJadVFkMVNDSWNXMGZaVWlaOE9m?=
 =?utf-8?B?RU91c2oxYXl2ZG5XdXdzUmF3UHhDaitsM2VPRWJ2RHEreXd5NkZ6aHJWQXBD?=
 =?utf-8?B?Z2tDWTdBbm90ZGlOMGVQN0s5MHZGYnNMZVk2eCtIK0hBN2RkM1RkN3hLUFpw?=
 =?utf-8?B?RnF2a09WOXhldlFZQkpUWldiZXQvWmdkUUcySkI5eUI2Q3FkQzc5K2FXb1ZT?=
 =?utf-8?B?L2Y4NWplWUhsVlQ3di9JMVBmZVZIdnFOWEI5SHV3eFozaHRnUmhPUjFybnlD?=
 =?utf-8?B?R2wza1BqK3ZBNUtaTVNDTWFlMHliZ1ZDWWpCblhmMS9PdDV6Q0ZDSXR1Sms1?=
 =?utf-8?B?aUw3dEluc09KT1ZnRGl4N1p0dkpEdFJQVlR6U0g2ZVQzSHlpVTMvSjNNSVBr?=
 =?utf-8?B?UFF6T2F0emZrQ2QyNXpFeGU3NGhvTzJHRzdTby91RmU1TkJvVXhWOTdZT0Rt?=
 =?utf-8?B?MHpucG9MSldodkF2UHFDMkp6QXlQWXA0dS9DRFI4c1RsemtEbDVwTkhSSWhO?=
 =?utf-8?B?TnZTeUYwTWhPZWdmRDJBeDRXWjVsYzIwMHZBZkRiMlpBVnQwOHIxeko0WEVZ?=
 =?utf-8?B?bFB0VUh6bWEvTkQ5WFZwdXJoVmNZZXZ1K1BRVmo0ZXB6UWNPNW8vZDJPZjNN?=
 =?utf-8?B?RXVDSUVpb2pDR20xQi9vcnliamFCd3Q2ZGFtNlhoNlo4dUQ0dzg4d1VtUVFS?=
 =?utf-8?B?blhIdHg4TU4rQTBMcUZNRzd6Vkd2K0FuSk9Ra3ZFeFh2L1hBTUlZem11bEFJ?=
 =?utf-8?B?T3hYMWorYkEycVlGajlIZExodURYVmJxRndnVldpaFdUNzA1b3N2Q0JvUTA2?=
 =?utf-8?B?MVdqbWkxekQxVEFHOEhyRkhKUjJXcUxCSkQ3Z2o0YTcrUnlOWlJwN0NRNHR0?=
 =?utf-8?B?TW9hMG1iVVdocmZkMmJaMGplY2NzRjNrQStDNWtEZUV5QmpkQUM3NnlEd2JT?=
 =?utf-8?B?aU1PZDFWYjNCbldHQUsyZndJZmt5TUh1RmhsZWZwUXV0amM2c1ppaXZKQThW?=
 =?utf-8?B?RkhMMnRPWW44Kzl1SjI1OWVPMzUxS05QWXlueWw3OFkramNTK1Z5Znpaa2ky?=
 =?utf-8?B?VXZ6cjYzem1pTHpYZ1hCK0JJZEE5a1lIVSt5QkNUakJrNHVJTFpjVFdUVjJz?=
 =?utf-8?B?cW1sRjU1cWZ0aDhDeGo2Q0VIN1FKcUVrQjlVWkdLd0ltUzFuWS9HeFpSTnlV?=
 =?utf-8?B?NlltbzdqdnJDclMva3lIN0JPQTRrNkJmUkIzMElHVGQrcElHbUV3VW9CTXNu?=
 =?utf-8?B?WG5tRS9kYkZKUmJMam1yU2dRTmwyQU1kWkhtcVM5MFVBNGhrM3ZIYTVtTExM?=
 =?utf-8?B?OUVoNEJ6K1NJRmgrNmtyK0ozWldNV3ZUMExUdStjNDQ5d1hDRmI3VDRzQytC?=
 =?utf-8?B?ajcrY0RFckJpa2Q3K3JZbDNLTDN2M2paYnlaVVJOMExVSSsyUStwM3U3d0hi?=
 =?utf-8?B?WVdtNzRYOFZBTHZXZzRXU2xtMVA0dEp4bGhvOVRXSU5vcFVyTHMzM29LbWVu?=
 =?utf-8?B?MUJIOXdrek45cXN1bFYvbnJJUUxobDFDYVN4T0RnSFNvUWJlUlhmd3FJa3FY?=
 =?utf-8?B?d3pZSjNmZmV5Qm4xTnBpbU5FSi8vTzh0SG9DdU1OZjA1QmVQdzh0SFEwVGR3?=
 =?utf-8?B?YjcvS0dEbGJwaUVGdEJNcThJRnJGRTYyVVJYZjNMeFRidER3T1Y0ZmdEQit3?=
 =?utf-8?B?RmhJQURVZHV5aTQ1VmgrVFl1TjNLWktJT3orcDEvNlZrRlJTZXNjMEtncC9B?=
 =?utf-8?B?WVdDZVgvU1BaTTBlYTNGQnFLVXFISU5zekN4ZHduMGYvanBPNVhUY3JmTGN0?=
 =?utf-8?B?bnUxa3JGYTZBemt1bTBVcFdkTm9NcXRtdklDTmQxbFQvRExyUllwUVkzTWp3?=
 =?utf-8?B?SFdHbjdXWlpDV0hzSkxkQkY1RnlHOG12ZTB1Nm1WMnNydkNDZHZXbFpYY2ox?=
 =?utf-8?Q?wiAPXvi+U2R3cEnj5FNMk7FK/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39647cd5-cbad-44ce-3c9c-08de1e4f60ee
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 22:45:41.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSJFsoO8wRziSwXYilJu6lJqQcqylxkO8MW9ymyaEBw9RLVAmQPmrjdcHhVzD+6ffOX6/Yln9M1YZYya94l9lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

Patch 1 Adds the binding for the msx4 cx8 switchboard
Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing the nvidia mgx cx8 switchboard.

Reference to Ast2600 Soc [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Changes in v2:
- Added ack by Conor Dooley on patch 1 
- Changed phy-mode attribute after discussion with Andrew Jeffery and feedback from Andrew Lunn
    and added a comment with a better explanation
- Link to v1: https://lore.kernel.org/r/20250918-msx1_devicetree-v1-1-18dc07e02118@nvidia.com

---
Marc Olberding (2):
      dt-bindings: arm: aspeed: Add Nvidia msx4 board
      dts: aspeed: Add a dts for the nvidia msx4 hpm

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 254 +++++++++++++++++++++
 3 files changed, 256 insertions(+)
---
base-commit: 38a2c275c3d3f7d7180d012386cd6fcf87854400
change-id: 20250908-msx1_devicetree-7af2c1fc15d0

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


