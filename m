Return-Path: <linux-aspeed+bounces-3509-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B667E9461F
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 23:11:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f90nR1lK4z2yql;
	Tue, 10 Feb 2026 10:11:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770621645;
	cv=pass; b=UKkTPL6cZZ+sXLvGBeUKPz5p5rlyLGZTMdbf8MIjnv486tywa6iZYK68XyNiyp3GcT9yZUIft3W6maP/aonE8XehETAHihkFD+Git4Ht7wVLGGxbHC7QYvCJiDVL0+RD1nL/KktYk8hAvK0k35sjf8ErE//gzk8WqtiVkqeJ+C1kvVedNjPTrqg2SN9Rn55Z0rwDv6jOfbg/reBmiEBn7iNo7CzvufD1Q6/7LD7ktxxqITVZ5OqK6avsx6nFLOma0fZx5xm06RZbD8DOMb3QdZbv2g9etoJQhIHrOoV7rcHt9o7pi5Qn6280cbqkM9h60SYmHPVmqiwLU+NGF/t3Cg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770621645; c=relaxed/relaxed;
	bh=eAWNz/Q7Q82qRTplT9zYyZozYszS9J7hSk/Falazpio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QRzxFSrAljXgYqoRvGmqA4rJotBqgDaJl0b/aRoP1rA6ZeX6wqdMKZekt6wS34/dI/nSkY+VZRXYmO0rhrQjgMff2nAZ2xjoKU+bk/MKSiMsyN4CjFu1uhwMgsXgnwu+tm5xtaddGruU8K3WWRlWtRs/wik4z76tBPISZlf5/qhg34E59GCMS15HCmmT973SamB9uF/F7XazSq3kctwXm2V4+PTRRU4/83cA1NFgt3B0lbCz2Yx+W6JxKtZSK/g6jQBfJPmAZu/LYAPpXMebuUPEMJkr1gJ+i51eJJYs3OoK3LCZjianRfghRFphHb1KVg4g/dkNbmSc0k5COVSRoQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aKl5t4RO; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=dirk.chen@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aKl5t4RO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=dirk.chen@amd.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8bhC20K3z2xHX
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 18:20:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhGike9zM2xNGUaX1QkVBGTQ+YEDhvzueMDdzOhxXNf+WBQfPs5QlRAvY4jdzAJQijLPXa+s3bvNkYsBS6bRlq7DPmtGDJCcBQ/QTL9HB/qGs0cjPmruMbH62nbu4WnNc19gkRxL6ColaEuy6xgXl4BS5GZev+sncn1lspdpjZk7rzwKBH5V3F4yLkO0v0lhb4gIgdNlEXl3PlrFYqcQpYIafva3leFKqBNaEcddsBtQCzaQRQKpeN3cb7xGcIFOHTTV79OKfCsgwJ/6iMOJeJmisbS8zdBpNHrtKeNzO82YtLyF3BJZZEPHin37CQaCC//Uaxik2rnfuXObfFXHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAWNz/Q7Q82qRTplT9zYyZozYszS9J7hSk/Falazpio=;
 b=mEkaKFtaXRrNFWuzBFuEkR5bLfGkBJ1RpqD79wNHmsCAHJ6clNNqwgkWl8QbCJTWJC41MM6Vrn/FLVtlchvBDB/VQakOkoOPZ5fBQbXsSLEGMHpkdKe/4enKCnlnCmVfdxslPurQnnHmgSQek7/oH+Zo3hxpTZRgaanSmXYRK1qipndnCJCxnS/hy9W1YUUa8c11WaJQFmZ/1iiddZoCgZjJOgBhlyTL9bMPvR1BkpAcuUXQURHgEQLKl/XuZK1uPxsWM4OFUf0HTh9KlqJyvkncNeVpVamL/qlZC5BiPpLWmcoVDjKlkUKzX8J0/6X/nZGoCfWuWgsYwuz/42wKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAWNz/Q7Q82qRTplT9zYyZozYszS9J7hSk/Falazpio=;
 b=aKl5t4RO4vTqG4aU7r8UD2uoJ/EE8V0uw7UyiLWZ6OcEOrssYIQ9mIf6iCdt4PwyL/iwq0VIYJGZ08awqY7jivs4knrYBpjfOuAh5++YSF+VeXC9lK9ClU+/r86xloZm1Qxs93CYiqoHvFgVDHYo1S4mIshEpE89yWGLe1nTg6E=
Received: from MN2PR12MB4031.namprd12.prod.outlook.com (2603:10b6:208:16e::16)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 07:20:13 +0000
Received: from MN2PR12MB4031.namprd12.prod.outlook.com
 ([fe80::5a8b:b2ec:74f5:af43]) by MN2PR12MB4031.namprd12.prod.outlook.com
 ([fe80::5a8b:b2ec:74f5:af43%7]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:20:13 +0000
From: "Chen, Dirk" <Dirk.Chen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
Thread-Topic: [PATCH] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
Thread-Index: AQHck+vG1AJWw2oynUCCCUBzavqoubV5+QOAgAAGOLA=
Date: Mon, 9 Feb 2026 07:20:13 +0000
Message-ID:
 <MN2PR12MB403135B2284FF07BE080B527E765A@MN2PR12MB4031.namprd12.prod.outlook.com>
References: <20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com>
 <324adcf0cbf87ef1186c70f09ab0e0ee2e29017c.camel@codeconstruct.com.au>
In-Reply-To:
 <324adcf0cbf87ef1186c70f09ab0e0ee2e29017c.camel@codeconstruct.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-09T07:13:06.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4031:EE_|CYYPR12MB8653:EE_
x-ms-office365-filtering-correlation-id: d9da7165-9cec-4d7a-fe12-08de67abaa99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDF4NDVKZ0hYc09ocXF6M0d5WWYvRkZrMSsvekg0SW53aUFPS1pPTmhWTFVF?=
 =?utf-8?B?SVppVThyeDBsQ0JGWnA1ZG9JcnRSZ1F1VFZPU0dzOU9UaWU2ZDJOMU1vYUJT?=
 =?utf-8?B?WUpHckdVZHFsVXYxd0h6U01xeStxNkNrS2EweGhNY1N1ZWNESjZYZlR6ajVS?=
 =?utf-8?B?OG9RK1FrMGFsbkpheTU2RzNTYXcxVXhDZ2FZeWhlSnVZUGlRMG5ScTNVSUxP?=
 =?utf-8?B?aTZQV0tDdWJVSWQ3MW04bzZ3ejhINUJxTEFQZ3llS3lzREt5L25XdkNWV2Fz?=
 =?utf-8?B?akFDQWszM3hDU3lxalI4eDgwSk5BNFlNRXI2U2tNTFFNL0xXSTExck4yTEpP?=
 =?utf-8?B?Si9ZajUvdDNvTmdnQ2pmbTNjT2srSmhtalcwQzFZSXcvQjlZTWpaSFpmdGZS?=
 =?utf-8?B?MndqWENxeTBscEFZaEIwNThmL1o3bVpFclFiV1VlNEcyZXVMYk9WMms3N0ox?=
 =?utf-8?B?RGZjS1RpK3E5Vzlpd2ZYQTVQMVlEWFBPT25STW90ZXRPMHM0QlRJVFZkUWYr?=
 =?utf-8?B?OE10Y3ZxMGRsdTNwcTZwQlJZK0t2WFBFNmtrU3gyQXdDZ09waXlyZjVpK3lW?=
 =?utf-8?B?VkYvU0JuQlo5UEFwNDMwQ0dYUVVqY2s4bzNoUXFhMGhpNG84dG9VcjdlTEgv?=
 =?utf-8?B?NWFYbXBqSHByaGpkUDZNSEo1SDRXWThETUE5SWlFcGcrZ3paYVZXakNKNEw0?=
 =?utf-8?B?cUlvdkdkMUpPdDNnUFlISjB0Szk4bXg0aW9GcjREV3dGTXFEZTZuem9Ha2Ji?=
 =?utf-8?B?NzNNTTlDVkdhMjBHYnZDOHNCZVYxRTBONU1pSzBUd1E0OE5Nb01oVVBSSk9h?=
 =?utf-8?B?c1lnSW0rODljMnVsdEd5TEFzY3BUTkZHc21HYmpLSUE3NjViMjFBYlVrazha?=
 =?utf-8?B?WXNLWGZ3bDVMaElTVWR0RmNsQXptc09MdTg3UFAyVmlpSkdEUURuWnBzMWFP?=
 =?utf-8?B?YlRCMi9WdVF2VndRdzhSVGpZdEtFV0VBVDVtWjhFT2ZHcXc2d1dRQkI1YzJH?=
 =?utf-8?B?RzRzWVB6MFdWQlpwOWNMN0JXMHo3TUVqTnlDSC9YZ2RFZWwvSUpQaEsrNGc2?=
 =?utf-8?B?c0Irbm0yM1kra0VFd01mamxaNkxlS3FmYWkrbnRPSU9GUE94djNpYWplWmZN?=
 =?utf-8?B?dDF0Z09sbU01ZjR6MzBPT3Zhb3FwcDdjRmxKVFh4NU10QURxY0YxNHVpeUtP?=
 =?utf-8?B?cTFkT2pBaTVJSlJoQ0JlQ3FvYWVQNGFYM2g2UTVaWjlZbHJ3SDlqK1E3R2Zy?=
 =?utf-8?B?Z085cDlEdzJRQjBiV3R4c3lndGYyQTBHbHlHdmFNcXg0dUsxZXhGV2lsRVNK?=
 =?utf-8?B?YnNOR0NsQlNNc3pOVktEdkpuTENaT2lEYWZmV2dGSEV0V3A1N0YvNUJ2dGdG?=
 =?utf-8?B?dXdLR3dMUjFHZ2pKTWdmUUdWTWNrNzZRaGdFQWF4TWtiK3pCeitjNHZUTDNG?=
 =?utf-8?B?cURLbTF5ZkY0S1NUeVlNaENmQW9LWXBQUzI3YXRlMWtnUXA3S1Y2blJpNEFj?=
 =?utf-8?B?SThvQTRuc09VWHd6YlZEZ25ocDduUXR6UmxqT0Eyd3VaUEljZUprcDFQSnZp?=
 =?utf-8?B?Nis1dXdqMnhPVnZHOFNhR1pUcVBxSTRocUxhaXFGa1JKZk9BTDZzQ1RDeFpK?=
 =?utf-8?B?bWlwYUp0RXNNVHdwQnJTZ1cxVE9Ocnd0RmlTcXhvRjU0T3dxM3lDWGF5U2Nt?=
 =?utf-8?B?R1dIRzB2ck1USjNFR29rNjhTeWJEa1QxMGl5QkJ1RjhRbU5KUWpjVE9KZ3p1?=
 =?utf-8?B?N01KNU1iUDloSUpWREJINU5pWGcrQTRHZ0xFeWNTRldzWmZ3aU1rdDNLUmg5?=
 =?utf-8?B?OUFHRTEvUjlJZTgrRVlQeXJmTTJydnVKbzdUTU5QNDYyNFJ4b2l6OWVaZ3pi?=
 =?utf-8?B?RWp2T2lGaS9TaWJsdWltVnBJamRMZEh6bUFTdHpmdm9BOSs1OHdrUFZqc0k3?=
 =?utf-8?B?NCtSM1M4S2lHcElPQkZmTVRsdXIrK0tCTzVEaWNzZzVpa1JrNlpxZXhaL1lU?=
 =?utf-8?B?OHdWaUZKRXZ6R0RxakxIL2VFSjE3T2tHM2FIMzMyeXZiYUk5NHI1MjExdEI0?=
 =?utf-8?B?T0tBQm9CRlRoS0lpSlVYc05KUUhWeEJENmVBemQ3QTZseGdKRzdSNkJKNWc1?=
 =?utf-8?B?Q0tpZXpiZ21RRWpkMStYYk83Uk1vTm1MMkVVcmZqOHk1cGM2aU4yZG1NcnFZ?=
 =?utf-8?Q?3AHrf4/EJQLX+7MnEYRQydg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3AvM3U0NzNuTmZJUC9wNVlUbW1wNElCajBWclNEMGdwU1FFT1U2Q0lYLzJr?=
 =?utf-8?B?RUNpNkRlVlBsdHA1a05Qb21nM0VNUE9ZMWFNTFo5ZENpaWpHRW5PR0ZoQ2VB?=
 =?utf-8?B?UkM3bmhIaUVsUjk2M0l1N2pqbng3T3JWRU9jSVVIZkc1UG9aY1ZQdFNDcC9X?=
 =?utf-8?B?cVRkV0lIRWtqMDNSNXFEWHFiUWdKUlI1N3I1Yno3dWdVRDczTk42b2tFQnZh?=
 =?utf-8?B?UDYzY1E1WDJpaDcraG45WDBXWDlaOVhwSzdnOFdZS0wxNVg5bkNONm5kOThE?=
 =?utf-8?B?TFFUSFBHRmx6NEgrM3RzcVMwTytocWhjdVpjYnBHSzAzaVdBeVM5cGtpdmJv?=
 =?utf-8?B?N2tQT0orR2c1ajRuUnVrek9lZ3hGYXVKcG1EUVRpcmIrNWdpckZobG0zME1o?=
 =?utf-8?B?R3JxNk9mNVczQmxuVGk2VE93clorZ1UrYk5vNEpiSnl6WWMreldMZ3I5N0Zv?=
 =?utf-8?B?d1lUcUEyRlpXZTFWbmdYYnFNWkExSm5XREV2QndqcC9Nc09pemsrWk9EUVdq?=
 =?utf-8?B?V1JldG9SQTEzZVBxWVFDQkZRSjVzKzg1ZFRvUnVick0xNGNrcEo2OWFCL2pY?=
 =?utf-8?B?TVQvcnFud01qMlZxNElDblM4eDNNdzdJTlRQRGVneDF2VUliQnpndkdYTFh1?=
 =?utf-8?B?Z3dMNmsvV3ZMMHREMFhzNVp5TWNlT050cDA4R0hQamZNNnYvMG5tMkxQVFdz?=
 =?utf-8?B?VFhnQkNnWktER2pUazNRWWpZVGVRK1NHdlU1SFpjdDZuSFkvaXZ4bnBXdGNu?=
 =?utf-8?B?WnZkaisxQi9HaWh5V24xV0d0WFVmUnRNenpabGorR1d4MjBwZUZVaVRiN1d5?=
 =?utf-8?B?RmNYejJadmx5WHp1cTZCcEZZMm9XckRUekhna0tXM1JWRUVvUWt5YjdGZGdz?=
 =?utf-8?B?ZEVoOU55U0ZMODZEOE44VVBUbnlJcnNjMTU2MFkybmpjMW55SDBhZFdOMklR?=
 =?utf-8?B?VnVERnQ5MjBnLy90Nm9hUUU3bFVrbUFpSlFwUzZSenBtUkE3QUlTSTRGdHl2?=
 =?utf-8?B?R1ViSEdhcWh6VHFsb2l5R3VqTHNKaFN4anlGTWkyUFQ4QURTK21UNlJLdWtt?=
 =?utf-8?B?S3YwWE4vaGtwcXA1YjRQeEFIUTJkK2N3OFhIOVhQVDBuUFdDTUpMTnY0R3dC?=
 =?utf-8?B?ZTd6anpMaGlFY3ZSMDQxN1RzUUYySUo0U3g3WEpvdDBnNjF6TlhyTU1EOWtZ?=
 =?utf-8?B?NENVd0ZuWDFmajdVNUxxbWtFYjZFdnpaNXdXWHhZNWtjVitEa2c4UWowSnR4?=
 =?utf-8?B?UDlGeEJRYlFZajFTQVliSFoyUEF3SFBhUVVnOFhnWjQyZUw3Q09pdXNwVDdn?=
 =?utf-8?B?L0FiTng3MERFMENId1FtSi8yVUdheGtkeWJJQzluNW1KYkFDWGZha3pyc245?=
 =?utf-8?B?TEp3TUZaSGhLT3oxU053RVltVjI3cC93SEtlVjJiWUc3Uk1BREpZWWVYa2hK?=
 =?utf-8?B?bGtENU1kbTdZV1BKT1FLU0Z4TWZQcjFJZ3BaeW1KeFdzekptWWUvdFNlR0sw?=
 =?utf-8?B?R3RYcVFZUlArWDQ2UjhZSDA3VmxsNTF0TlRsdnFTVkkyKzN4MlRaTTRPWmZR?=
 =?utf-8?B?alY1YUtOelgwN0FKMVF6TGd2bktYYmtmSjNUcFAvVmdoMTFnNG82SEZBb3M0?=
 =?utf-8?B?RVRqZnBCT0UvenpmUmhSaVRLOEpKWnB0Qk9rME52ZmUxSkpMcGx4YmkrTVJN?=
 =?utf-8?B?SFlqTklPczNPUW5mQjRvRGxZUzVaZFFGTzJMRllyTGk5dVJ1QUpBRnJmem9x?=
 =?utf-8?B?YXdtVUMvNjFQR1AwZmg5U1ptNTAxUU5RSTZnUGs5RmZoUkNNa0pqdTd3clRB?=
 =?utf-8?B?Zzl3MlhBNFpJdzV4UlJ5ZjBoK3lFa0VrNjF2ODlFTWFBNXRSaW5DRzJzRkpj?=
 =?utf-8?B?Rk9JQmNNYXpybzN1dzdxNHZMUEFsRm54WDNJcGczRzVQVGVKdmk5OWZXTm05?=
 =?utf-8?B?Q0FPNCtPeE1Ia1FQNVRlRTFiNitTWVR0dFdCUG9rakw5Ynh3TlE3R2k2TjhQ?=
 =?utf-8?B?S015TkRPNEtLNzluSGFTODJ0a3pYNDFZQUZxdm1PU3F5TkRzRXZUbjJwb29V?=
 =?utf-8?B?Wkt1TjlneVhhMVZWOVlCb1FiNDdHL1RJd3NnYTYxWWFyZ21hYnZERUJJU2Fi?=
 =?utf-8?B?Mm5TVklkWkYxcDJ1ekVNaDcrOFJxZ3FpL0dKTk1FaXBIWWxRZTRib2JBcWVW?=
 =?utf-8?B?TFk5VGQrL2lpL2wySmo0OWVleWxHZmdlWTJhV1hnZHY5VXQrNlBvdHlWY3Va?=
 =?utf-8?B?a09FZy9LMGZPRXEvczd6MENLT25OVWVVRk9RVXNMQm1mTTVJS3lLckFYSnht?=
 =?utf-8?Q?zxP0awuiXlHcKOjYNq?=
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da7165-9cec-4d7a-fe12-08de67abaa99
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:20:13.1622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQoty5aRDZmjb7tlEz+6mz2Qi27Loj5UZ8D1HpCCeN8Thx+zaWzrtyQuVREyHIb4I8FcHsQ52qEx2j5wggXeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiBUaGlzIGRlc2NyaXB0aW9uIHNlZW1zIHN1cnByaXNpbmcuDQo+IERvZXMgdGhlIGNoYW5n
ZSByZWZsZWN0IHRoZSBoYXJkd2FyZSBvciBub3Q/IFdoYXQncyB0aGUgc2lnbmlmaWNhbmNlIG9m
IHRoZSBjb25zaXN0ZW5jeSBjb21tZW50IGlmIHNvPw0KPiBBbmRyZXcNCg0KSGkgQW5kcmV3LA0K
DQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQpZZXMsIHRoZSBjaGFuZ2UgcmVmbGVjdHMgdGhlIGFj
dHVhbCBoYXJkd2FyZS4gVGhlIEFuYWNhcGEgYm9hcmQgaGFzIHR3byBFRVBST01zIG9uIGkyYzAg
YW5kIGkyYzEgZm9yIHJldGltZXIgY29uZmlndXJhdGlvbi4NClRoZSBtZW50aW9uIG9mIHRoZSBI
YXJtYSBwbGF0Zm9ybSB3YXMgaW50ZW5kZWQgdG8gZXhwbGFpbiB3aHkgSSBjaG9zZSB0aGUgImF0
bWVsLDI0YzIwNDgiIGNvbXBhdGlibGUgc3RyaW5nDQogKGFzIGl0IHdhcyBwcmV2aW91c2x5IGFj
Y2VwdGVkIGZvciBzaW1pbGFyIGhhcmR3YXJlIGluIHRoYXQgcGxhdGZvcm0pLCBidXQgSSBjYW4g
c2VlIGhvdyB0aGF0IGNhdXNlZCBjb25mdXNpb24uDQoNCkkgd2lsbCBzZW5kIGEgdjIgd2l0aCBh
IGNsZWFyZXIgZGVzY3JpcHRpb24uDQoNCkJlc3QgcmVnYXJkcywNCkRpcmsNCg==

