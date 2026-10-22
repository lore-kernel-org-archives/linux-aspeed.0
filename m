Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4E606A31B
	for <linux-aspeed@archiver.kernel.org>; Thu, 22 Oct 2026 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KwmRxsbU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9M0Q3wq4z2y7W;
	Thu, 22 Oct 2026 20:53:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c406::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792662790;
	cv=pass; b=mOQU3rwSaW+Fg1L6SG094+4xK71xVTzXRC2xPyrEVYDVwf6hafZwfDIETJDQuB9SxQLJbPaulfZptV2ClhVbIyJoflbo4CvLHxfsxtoaTf6y2344/6l1zOY2ijCFzH6E0kIofwAOuMmiVyyZTCeKV3CGwaxI8mo9Wa79nVf/JW90Dc7gp8V6sVqVIYpSXEFFSMzRwTIsVcuz/7bn59487UL6ETfMOg6Uq9wpq9JOCVLmbWGkdCunGea2zJVCDPzuYmarNyfuuJ+6vjvD2IyCmZ0arfTGs1rUMKev2aKpIzgUsmXV57eJtoXz/TQgp5adR7i9WL32lj6L5sXHb5s3UQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792662790; c=relaxed/relaxed;
	bh=8Z6phzq4o9KkpX1gB6koBcHx6gVreC5wsmVVMeSFB2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hxp8g/mURk5T5k6VQGtbmmRv0BnEoNiOE7IVbLSSN1F6pJqu+DFLqOLBTfNiVD1K3xbpUI9kikXzoQ8PAgfG/A11CkV60er3ohPVWjHGcjPNLJ9CSh4n+D9s+kzmyXhZB1ZqoYDLZ8VejucI/hy6BimnryyF12C862Dskxs8y820cM5pfyDBhQFeQIZenf9Q21KmlvuKkVJLyzEOXroPqh7tPKXENgFsKrWNeZXgWJtyesRaE7bWNrOB/UkXFEyFZanLdft53OcE3ucFltZL8TZT9EHoBJxhW2LSXNNrC3Wrv85Y0MG6B+lKU7M+09StEymbblUGeDbFv7CgWmFE/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KwmRxsbU; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=KwmRxsbU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=2a01:111:f403:c406::3; helo=os8pr02cu002.outbound.protection.outlook.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazlp170120003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c406::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9M0M3PWlz2xKQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 20:53:07 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNKI8u9l6ktd8dy67MIvLH1LK1eAMMVC2SF2rOlhDHiyitZscQDwD0sGrW8sSaFeu0bbyHvrDVD2F3XBv948aBGwdnmcA2zL3bjCw5mDne91szY/VRuQk1C2Vj9uQSqKSyo1GQIBQEjnjHElrzYWtk7qe5RmMctzZF/MVzpzzC7rTyZmZEgIy5olg85lUOpyne7z8VLDAX9ra2fn3z9XG2n963g+oOthy9vYUdaHz1/YDVrPPI82SRtcr8dOT7ySWRW+pYADhirFRDbyOlu+0kTBjSEXzYt75VfbeigjrQ65mOpvKSk4ybsC3xCLKBL/aOzJ5Tu3I2Xm5mMDXdKbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z6phzq4o9KkpX1gB6koBcHx6gVreC5wsmVVMeSFB2U=;
 b=dEWRipB2Epvhb88eb6H6+Asww+otHOuvVWICR6CRhL0rBHe5jpDDlEq6aV6ZTjD23u7BZL/ywaCIAcbfpqSNGmVJTSYjvYxB0mJCXhfQqdYmTnURdzj7eFePyMguErrYCBZKR4DEgDPiMH8zau18hEePvvM2fmVNhxJucM4eCPuXBE3SClKxZC9O3jVxUrO7SR+hrRVPmivzZwft1/Wf86R8yMNGt78GqDr/PdEoLm+wrwXGR16A/h1SB9CBJTrmNi0ovE2Ap+dWZicYnr9KU+ewjgRbcvqq5FW46QncanNSn+xPCTHA9xyX8q/6GG+Ll855QS6CdC4C+8YfNgm58g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z6phzq4o9KkpX1gB6koBcHx6gVreC5wsmVVMeSFB2U=;
 b=KwmRxsbUjcdyksXLDaLLdkuu5dTsh3aqN5QdbUs5/7XxAYbuX2rUvpNp3NyDRLSl0P+7cD+QXUmySaaj/u/8Tn//WHb5qO6PxLO35vl5a5StTJwcoZgMecC2qDZNqZd6i6f+sgk97a64SCf7vYsYGYlfFh766hUTG5EGzojmF6uaWnTqFb2mLb4fkcPGCwNGEp0E4pYNEEGf9lXI/C9sQwh72f6H+t7+6fslhaJi/CtG09uuIz+n5qGVE+/eAf/7/kw6+BZJx0Y9kfjlXqp6IkzWV1IhJXfQGJPUogXgAbmDU+NduN3pOZzvUl7fw76xLmjoSAc8iycBCPfvgiSUNw==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by KUYPR06MB8723.apcprd06.prod.outlook.com (2603:1096:d10:8e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Thu, 22 Oct
 2026 09:52:37 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::e00f:6219:946c:195e%4]) with mapi id 15.21.0569.000; Thu, 22 Oct 2026
 09:52:36 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Stefan Schaeckeler
	<sschaeck@cisco.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: RE: [PATCH v5 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Topic: [PATCH v5 0/9] Add Aspeed AST2700 SDRAM EDAC support
Thread-Index: AQHdViL12A+l5SpHfkGkIr76gXxHGrcJaaIQ
Date: Thu, 22 Oct 2026 09:52:36 +0000
Message-ID:
 <TY2PPF5CB9A1BE6C09C55652B1A6AA68725F2652@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
In-Reply-To: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|KUYPR06MB8723:EE_
x-ms-office365-filtering-correlation-id: e4c0dedf-2d46-4997-577c-08df302233bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|261021121427099003|38070700021|56012099006|261009223027099003|10067099003|261021123027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 fxYURV0PAdt4eKDqlDIDy2iPWObI4l9KoUhKsWDiSCAtgK+Obmbazk0IPfxRl3RtNyZ/LEe8HvXleeP6i27XByzgmSo3hgmSgz9XrdoVH824EGTUFPuBihIMPziPKMKDbjUQZIqkD0/8yTV6k/ExYjMrF0bquGprvtiNH1L2frWNqMJAc8Kgz7ZSvX7y7wS8yH8BkZ6QU+WxCVs2s2WpXauha+pWL2/R4i4fUjTHn/QnTCa+ZweW1iuM0slqvxYjwnem7KyDgadAHt0K8rP89ji2IxsKA/zXWQzvEx2P23l8t7uC30MF6BRV+wNJg0dGw4cWxadUZPByohBSyzwXYZnmKFuuDgyQeK+1JyUSd+9Ubhf8p2DYCspDzpkrJwr1O83yJ04grEJajlea50zh1Famiy2PEw3hEBsZC45LJuea/pVbHlCoZt2En15DZ12i2k+Fq8FrZ7aD1hEXCIh3W9ovXv8e87xAnpaflTyZVor4bY/GDNSWHnFMdlLixakmaFQsQhNI97npVH0rsDj8JkBaOXLZoaYkdgtjXhsUbFjsvkMiHYcR6DqG/zfuReDMOz96ii2tx/fKRK+b76RJFQXkXKYGioRGiROS6u9LrZJn83PaZH+wxGeIVcQ17Gw09YN5sBn/2SU9E69BdlbfS3lVMvsu6TrVIC9aS/YHC4U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(261021121427099003)(38070700021)(56012099006)(261009223027099003)(10067099003)(261021123027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZTlqbnNSTDA2K1dhNERjdFRqOFBkOVFENXlqRHRxQ3BJdDl3a3V5c21qSmJo?=
 =?utf-8?B?T2U3QktnUElyUHBNQThLcmd2Nm91dXdndXFId1lKZVBXTXJLTHBMeDB5RzVN?=
 =?utf-8?B?bjZFaDJiWERpQTlVMWhaeGlldFczbm9HWkIxMVdsNUdJZ3A4SmhkZEsvbk11?=
 =?utf-8?B?b2htbi9SUWYvbnp5c1cxVXUxSWIxT1JtL002V1hrTzlScGc5TG1BZ1p2Q1pE?=
 =?utf-8?B?WmVwU0FvNjdmaGxHWFJhUWhDNEU4NU12a2RpeXRWUk5PNURKZ040MmpEZExy?=
 =?utf-8?B?cjRGb3ZncnhQNHFBc1AzRmx2YlZpUzNld041amRqeUZpRHIxZ1dEQlJMSU0y?=
 =?utf-8?B?NUZQcTJwZkFRU0hnTjNoc0FUcy81dEhZemVXbytRaU5TL3Y5Tjd6MjRONkMv?=
 =?utf-8?B?d0V5ZjNLMkErbGVtRzd2cUhySkdnTjRrTzBHelF0UGlzT1pnMFZNSWJERkNh?=
 =?utf-8?B?WVM2clpTbkY1R0R4YkRobnpOdWxuMW84bjRkVHpwNTU4QWVERnFWd3FEeUZs?=
 =?utf-8?B?USticVVrelI0ZXU0VWEraHBzUDRGMEdzMUN0b1RBUnJpcER4QU1uK1kyWXQw?=
 =?utf-8?B?SEljampBQnhHd2xDMENCS3RtcDExMDVkSHA2eSsrZmtVSkR1T2kwaUV2NXBv?=
 =?utf-8?B?K24xVkZYV3F1MGQ2em1pSjZ1N3MzbzJJeXh4YUQ4NmVmVFhlMjJwQUpHelRY?=
 =?utf-8?B?a2JpZ2sxRUtSOUJ6aTdUaTlsOHdacFF2VE5KQThmNkFLam5ncWdQRm1ZYkRK?=
 =?utf-8?B?a2grUUU4cUdlTlE5UEdZL01ibnB1MVdsckJTdWg2bzV4bjlpVWQ5VWVKeE11?=
 =?utf-8?B?QS9PR2FlOGhleTErc0l5TTB6TXlhYTJkU0RNaXdONlFKeVE4RDlGbU52eUhw?=
 =?utf-8?B?eW5WdU1kK01iK2JWbGlHaFBtN1N3dGh0ZXVoV2tDV29NZDI4MkZzRkVUUkM3?=
 =?utf-8?B?K1pncTNlR2IrNENiUmpYSWVvSkR1UWlhZzBhUm1mMGRZMVZudVdacStWUWhu?=
 =?utf-8?B?U0x4eU0yUXMvN3FndGdJZVVTbEd1Vm1iRHBsNXVDTG1DMnNNREpTdjI2NFNB?=
 =?utf-8?B?VHJPdXM0NGhwRHpsZWZhcXFWYUplTzVkZEUzVncyZWozOG9Va1BWb2tPcy9j?=
 =?utf-8?B?dTZ0SFFDM05UemZCUXo3MlBmRVp3VmFXZVNmaUpCL2EvVkM4eGJ2SFFtRG9v?=
 =?utf-8?B?RDlBUE52VzFDYnNiYjJST0Y1TTYwQzRQem5RaWZwQml5SkZHcUZnaHdieXd3?=
 =?utf-8?B?bUZ3b1RHbURsYzVGZVExYjBqSjBYZW5WZGxERmVvWkFvSndQOXk3UjRublQr?=
 =?utf-8?B?a2E5azZ5dGU0anZlbmdwY2luc0NOSE9NdDR0cEZ5RXF4aVB6N0lxSlllaVlB?=
 =?utf-8?B?VG1QQjhxaVNKYk1MeTU2U1dvakl6cHZJZHFlcUZQcXRxKzJ4NjlGQmpKbVpS?=
 =?utf-8?B?OXN2NVRVV1RoZ0s0K3V3SlUxR1BhNDVwUEpFbVRpTlFaR0J0TlhtbnpaZUNt?=
 =?utf-8?B?L3B4QTVHOVIzRVloWHpCOTBKaWZic0NjVlRxb2syNDFBbk5qdlc4dzl0dGZT?=
 =?utf-8?B?R1l4UkxyVHNFRm9mbXBDdFBIMWYxSWZnVUswbWttdTN3c2tDdnZ5d1k1Ykkv?=
 =?utf-8?B?dU5GU1R6ak5XYmNPRkxKbGRFTlRiNlcxb0U4UkNEWXFwcmRQWWx2L2srRDlp?=
 =?utf-8?B?UHVod2dUT3NROEpsc0NLckZNU1RrRXhCNk13WExuaCtkVjlnckFxajVjVXA4?=
 =?utf-8?B?MG4rN3E2YkdreG9PTW1Pek9sRXlnWk0yR3dvNTlCK2oycFgxcFZaak5xZ3NI?=
 =?utf-8?B?L3lTZ0xLUWZaTWE0VWZ0bDNad0RJSTVycVFZaTdyaHRnVTRiUndaVk80MjNC?=
 =?utf-8?B?dktrL2NRV0MzOHgrUVcvNmdGL2hzMzBEcVJKUjg4cWVydzYrY0VaeGVhczdk?=
 =?utf-8?B?UlpudFVxRTJLRWllamdWcmphN3NVL2lyNys0OTIwaXpmY21tRnZPa1pMS1U2?=
 =?utf-8?B?WHI5S2M5NE05SGF4cHJWTEJiazJLRmUrQk55UkF2VXA5K1UybXRyN0dNZjBF?=
 =?utf-8?B?SWF0WVlSQ1JRRk5VL0NnSktUNnZ5OWo1K0dwL1JsSjkxcnRYcDJaVUExV1J6?=
 =?utf-8?B?Mi9lbEM5OFNsRlhLZEtoVGx6RzJ1Um1uSkV3WWhYYnY0RHNZcVY0ZFRVOHcy?=
 =?utf-8?B?Qkl2UDd5cGloUFQydXJtd1NaTXZtVTY1N09QdE1LdVFkV3g0TmRNaUxwSnc0?=
 =?utf-8?B?ZzNnM1VJODVKMzVxZzJ4enhOaU1PQnNGeEhHZG5FV2U3Qm9PMGM0cU5STVZ3?=
 =?utf-8?B?TlJZZ05Qb1F1WDUvbVo5VUdXSzc1YTR2RFVkZy82cGVVWTNZTXN4QT09?=
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c0dedf-2d46-4997-577c-08df302233bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 09:52:36.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vKjYm7pUsJR5efXCsMLTHPlf91vQ0f/Bbh34mWha0bTpklvdKjFBGKZ6/35OUJ+jg2aaQ/UO0nivvO+s2lZJoy2zp208ny/C3ImLyKn6sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8723
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8gQm9yaXMsDQoJSnVzdCBhIGdlbnRsZSBwaW5nIG9uIHRoaXMgc2VyaWVzLg0KCUFueSBm
ZWVkYmFjayB3b3VsZCBiZSBhcHByZWNpYXRlZC4NCglQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhl
cmUgaXMgYW55dGhpbmcgSSBzaG91bGQgYWRkcmVzcyBvciByZXZpc2UuDQoNClJ5YW4NCg0KDQo+
IFN1YmplY3Q6IFtQQVRDSCB2NSAwLzldIEFkZCBBc3BlZWQgQVNUMjcwMCBTRFJBTSBFREFDIHN1
cHBvcnQNCj4gDQo+IEFkZCBFQ0MgZXJyb3IgcmVwb3J0aW5nIGZvciB0aGUgQXNwZWVkIEFTVDI3
MDAgU29DIHRvIHRoZSBleGlzdGluZw0KPiBhc3BlZWRfZWRhYyBkcml2ZXIuDQo+IA0KPiBUaGUg
QVNUMjcwMCBtZW1vcnkgY29udHJvbGxlciBrZWVwcyB0aGUgc2FtZSBvdmVyYWxsIEVEQUMgcHJv
Z3JhbW1pbmcNCj4gbW9kZWwgYXMgdGhlIGVhcmxpZXIgQXNwZWVkIEJNQyBTb0NzLCBidXQgdXNl
cyBhIGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQsIGENCj4gc3BsaXQgaW50ZXJydXB0IHN0YXR1
cy9jbGVhci9tYXNrIHNjaGVtZSBhbmQgRERSNC9ERFI1IG1lbW9yeS4NCj4gUmF0aGVyIHRoYW4g
Zm9yayB0aGUgZHJpdmVyLCB0aGUgZXhpc3RpbmcgY29kZSBpcyBmaXJzdCB0aWRpZWQgYW5kIGdl
bmVyYWxpc2VkLA0KPiB0aGVuIHRoZSBBU1QyNzAwIGlzIGFkZGVkIGFzIG9uZSBtb3JlIHBlci1T
b0MgdmFyaWFudC4NCj4gDQo+IFBhdGNoZXMgMS00IGFyZSBidWcgZml4ZXMgYW5kIGNsZWFudXBz
IHRvIHRoZSBleGlzdGluZyBkcml2ZXIuIFBhdGNoIDUNCj4gZG9jdW1lbnRzIHRoZSBBU1QyNzAw
IGJpbmRpbmcsIHBhdGNoZXMgNiBhbmQgNyByZXdvcmsgdGhlIGltcGxlbWVudGF0aW9uDQo+IHRv
IGFjY29tbW9kYXRlIGl0LCBhbmQgcGF0Y2ggOCBhZGRzIHRoZSBBU1QyNzAwIHN1cHBvcnQgaXRz
ZWxmLiBQYXRjaCA5IGlzDQo+IFN0ZWZhbidzIHN0ZXAtZG93biBwYXRjaCwgYW1lbmRlZCB0byBs
ZWF2ZSB0aGUgZW50cnkgaW4gcGxhY2Ugd2l0aCBtZSBhcyBpdHMNCj4gcmV2aWV3ZXIuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4g
LS0tDQo+IENoYW5nZXMgaW4gdjU6DQo+IC0gUmVnaXN0ZXIgdGhlIEVDQyBpbnRlcnJ1cHQgd2l0
aCByZXF1ZXN0X2lycSgpIGluc3RlYWQgb2YNCj4gICBkZXZtX3JlcXVlc3RfaXJxKCkgZm9sbG93
ZWQgYnkgYW4gZXhwbGljaXQgZnJlZSwgYW5kIGtlZXAgdGhlDQo+ICAgaW50ZXJydXB0IG51bWJl
ciBhbG9uZ3NpZGUgdGhlIGRyaXZlcidzIG90aGVyIHN0YXRlIHNvDQo+ICAgYXNwZWVkX3JlbW92
ZSgpIGRvZXMgbm90IGhhdmUgdG8gY2FsbCBwbGF0Zm9ybV9nZXRfaXJxKCkgYWdhaW4uDQo+IC0g
TGluayB0byB2NDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDkzMC1lZGFjLXY0
LTAtYzJlNTI2ZjNlZDc5QGFzcGVlZHRlY2guY29tDQo+IA0KPiBDaGFuZ2VzIGluIHY0Og0KPiAt
IFB1dCB0aGUgYnVnIGZpeGVzIGZpcnN0OiB0aGUgdHdvIGZpeGVzIGFyZSBub3cgcGF0Y2hlcyAx
IGFuZCAyLCB0aGUNCj4gICBjbGVhbnVwcyAzIGFuZCA0LCBhbmQgdGhlIGJpbmRpbmdzIHBhdGNo
IG1vdmVzIHRvIDUgYWhlYWQgb2YgdGhlDQo+ICAgQVNUMjcwMCB3b3JrLg0KPiAtIEV4cGxhaW4g
aW4gcGF0Y2ggMSB3aGVyZSB0aGUgZ3JhaW4gdmFsdWUgY29tZXMgZnJvbSwgcmF0aGVyIHRoYW4g
dGhlDQo+ICAgd2FybmluZyBpdCBzaWxlbmNlcy4NCj4gLSBEcm9wIHRoZSBDYzogc3RhYmxlIHRh
Z3MgZnJvbSB0aGUgdHdvIGZpeGVzLiBOZWl0aGVyIG1lZXRzIHRoZSBiYXIgaW4NCj4gICBEb2N1
bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1ydWxlcy5yc3Q7IHRoZSBGaXhlczogdGFn
cyBzdGF5Lg0KPiAtIE1lcmdlIFN0ZWZhbidzIHN0ZXAtZG93biBwYXRjaCBpbnRvIHBhdGNoIDks
IGtlZXBpbmcgdGhlIE1BSU5UQUlORVJTDQo+ICAgZW50cnkgYWxpdmUgd2l0aCBhIHJldmlld2Vy
IGluc3RlYWQgb2YgcmVtb3ZpbmcgaXQuDQo+IC0gTGluayB0byB2MzoNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8yMDI2MDkxNi1lZGFjLXYzLTAtMjNlOWVkMmZiZGY5QGFzcGVlZHRlY2gu
Y29tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEVzdGFibGlzaCB0aGUgQVNUMjcwMCBpbnRl
cnJ1cHQgbWFzayBpbiB0aGUgZHJpdmVyIHJhdGhlciB0aGFuDQo+ICAgZGVyaXZpbmcgaXQgZnJv
bSB0aGUgcmVnaXN0ZXIncyBjb250ZW50czogYXN0MjcwMF9zZXRfaXJxKCkgbm93DQo+ICAgd3Jp
dGVzIHRoZSBtYXNrIG91dHJpZ2h0LCBtYXNraW5nIGV2ZXJ5IHNvdXJjZSBhbmQgdW5tYXNraW5n
IG9ubHkNCj4gICB0aGUgRUNDIG9uZXMsIGFuZCB0aGUgbWFzayBpcyBlc3RhYmxpc2hlZCBiZWZv
cmUgdGhlIGludGVycnVwdCBpcw0KPiAgIHJlcXVlc3RlZC4NCj4gLSBOZXcgcGF0Y2g6IGFkZCBt
eXNlbGYgYXMgYSByZXZpZXdlciBmb3IgdGhlIGRyaXZlciBpbiBNQUlOVEFJTkVSUy4NCj4gLSBU
ZXN0ZWQgb24gYW4gQVNUMjYwMCB3aXRoIENPTkZJR19QUk9WRV9MT0NLSU5HPXk7IGluamVjdGVk
IGNvcnJlY3RhYmxlDQo+ICAgZXJyb3JzIGFyZSByZXBvcnRlZCBmcm9tIHRoZSBpbnRlcnJ1cHQg
aGFuZGxlciB3aXRoIG5vIGxvY2tkZXAgcmVwb3J0cy4NCj4gLSBMaW5rIHRvIHYyOg0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjYwODI0LWVkYWMtdjItMC1jOGQ4YmI2OTM1ODZAYXNw
ZWVkdGVjaC5jbw0KPiBtDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIE5ldyBwYXRjaDogZnJl
ZSB0aGUgRUNDIGludGVycnVwdCBiZWZvcmUgdGhlIG1lbV9jdGxfaW5mbyBpbg0KPiAgIGFzcGVl
ZF9yZW1vdmUoKS4gVGhlIGludGVycnVwdCBpcyByZXF1ZXN0ZWQgd2l0aCBkZXZtX3JlcXVlc3Rf
aXJxKCkgYW5kDQo+ICAgaXMgb25seSByZWxlYXNlZCBhZnRlciAucmVtb3ZlKCkgaGFzIHJldHVy
bmVkLCBzbyBlZGFjX21jX2ZyZWUoKSBjb3VsZA0KPiAgIGZyZWUgdGhlIGhhbmRsZXIncyBjb250
ZXh0IHdoaWxlIHRoZSBoYW5kbGVyIHdhcyBzdGlsbCBydW5uaW5nIG9uDQo+ICAgYW5vdGhlciBD
UFUuDQo+IC0gQWNxdWlyZSB0aGUgcmVnaXN0ZXIgbG9jayB3aXRoIHRoZSBpcnFzYXZlIHZhcmlh
bnQgaW4gaW5pdF9jc3Jvd3MoKSBhbmQNCj4gICBpbiBhc3BlZWRfcHJvYmUoKS4gVGhlIGludGVy
cnVwdCBoYW5kbGVyIHRha2VzIHRoZSBzYW1lIGxvY2sgaW4gaGFyZGlycQ0KPiAgIGNvbnRleHQu
DQo+IC0gTW92ZSB0aGUgZGV2X2RiZygpIG9mIHRoZSBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVy
IG91dCBvZiB0aGUNCj4gICByYXdfc3BpbmxvY2sgY3JpdGljYWwgc2VjdGlvbiBpbiB0aGUgaW50
ZXJydXB0IGhhbmRsZXIuDQo+IC0gT3B0IGFzcGVlZF9lZGFjLm8gaW50byBjb250ZXh0IGFuYWx5
c2lzIGluIGRyaXZlcnMvZWRhYy9NYWtlZmlsZS4gVGhlDQo+ICAgY2hlY2sgaXMgb3B0LWluIHBl
ciBvYmplY3QsIHNvIHdpdGhvdXQgaXQgdGhlIF9fZ3VhcmRlZF9ieSgpIGFubm90YXRpb24NCj4g
ICBhZGRlZCBieSB0aGUgc2FtZSBwYXRjaCB3YXMgbmV2ZXIgYWN0dWFsbHkgdmVyaWZpZWQuDQo+
IC0gUmV0dXJuIElSUV9OT05FIGZyb20gYXN0MjcwMF9kcmFtY19pc3IoKSB3aGVuIG5vIEVDQyBp
bnRlcnJ1cHQgc3RhdHVzDQo+ICAgYml0IGlzIHNldDsgdGhlIGhhbmRsZXIgY2xlYXJzIG9ubHkg
dGhlIEVDQyBiaXRzLCBzbyB1bmNvbmRpdGlvbmFsbHkNCj4gICBjbGFpbWluZyB0aGUgaW50ZXJy
dXB0IGNvdWxkIGxpdmVsb2NrIHRoZSBsZXZlbC10cmlnZ2VyZWQgbGluZS4NCj4gLSBUZXN0ZWQg
djIgb24gYm90aCBBU1QyNjAwIGFuZCBBU1QyNzAwIGJ5IGluamVjdGluZyBhIGNvcnJlY3RhYmxl
DQo+ICAgZXJyb3Igd2l0aCB0aGUgbWVtb3J5IGNvbnRyb2xsZXIncyBFQ0MgZXJyb3IgaW5qZWN0
aW9uOyBlYWNoIGlzDQo+ICAgcmVwb3J0ZWQgYXMgYSBDRSB3aXRoIHRoZSBleHBlY3RlZCBmYWls
dXJlIGFkZHJlc3MuDQo+IC0gTGluayB0byB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI2MDgxMi1lZGFjLXYxLTAtMDM5OTJlZGVhMjk3QGFzcGVlZHRlY2guY28NCj4gbQ0KPiAN
Cj4gLS0tDQo+IFJ5YW4gQ2hlbiAoOCk6DQo+ICAgICAgIEVEQUMvYXNwZWVkOiBTZXQgdGhlIERJ
TU0gZ3JhaW4NCj4gICAgICAgRURBQy9hc3BlZWQ6IEZyZWUgdGhlIGludGVycnVwdCBiZWZvcmUg
dGhlIG1lbV9jdGxfaW5mbyBvbiByZW1vdmUNCj4gICAgICAgRURBQy9hc3BlZWQ6IENsZWFuIHVw
IHdoaXRlc3BhY2UgYW5kIGluY2x1ZGUgb3JkZXJpbmcNCj4gICAgICAgRURBQy9hc3BlZWQ6IEZy
ZWUgdGhlIG1lbV9jdGxfaW5mbyB1bmNvbmRpdGlvbmFsbHkgb24gcmVtb3ZlDQo+ICAgICAgIGR0
LWJpbmRpbmdzOiBlZGFjOiBhc3BlZWQ6IEFkZCBBU1QyNzAwIFNEUkFNIEVEQUMNCj4gICAgICAg
RURBQy9hc3BlZWQ6IFJlcGxhY2UgcmVnbWFwIHdpdGggZGlyZWN0IHJlZ2lzdGVyIGFjY2Vzcw0K
PiAgICAgICBFREFDL2FzcGVlZDogQWJzdHJhY3QgU29DIGRpZmZlcmVuY2VzIGJlaGluZCBjaGlw
IGRhdGENCj4gICAgICAgRURBQy9hc3BlZWQ6IEFkZCBBU1QyNzAwIHN1cHBvcnQNCj4gDQo+IFN0
ZWZhbiBNIFNjaGFlY2tlbGVyICgxKToNCj4gICAgICAgTUFJTlRBSU5FUlM6IFN0ZXAgZG93biBh
cyBBc3BlZWQgQVNUMjUwMCBFREFDIGRyaXZlciBtYWludGFpbmVyDQo+IA0KPiAgQ1JFRElUUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKw0KPiAgLi4u
L2JpbmRpbmdzL2VkYWMvYXNwZWVkLGFzdDI0MDAtc2RyYW0tZWRhYy55YW1sICAgfCAgIDggKy0N
Cj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAyICstDQo+ICBkcml2ZXJzL2VkYWMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2VkYWMvYXNwZWVkX2VkYWMuYyAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDQyNQ0KPiArKysrKysrKysrKysrKy0tLS0tLS0NCj4gIDUgZmlsZXMgY2hh
bmdlZCwgMjkzIGluc2VydGlvbnMoKyksIDE1MSBkZWxldGlvbnMoLSkNCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiA1NDY0OTg1ZTQyYzA0ZTMzNWZiMzBlMzhmYmM0MDljOTk3ZGI5YmVjDQo+IGNoYW5n
ZS1pZDogMjAyNjA2MjUtZWRhYy04ZTk2MGUwMmU3ZjcNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
LS0NCj4gUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQoNCg==

