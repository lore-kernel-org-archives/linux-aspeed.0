Return-Path: <linux-aspeed+bounces-2588-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71E4CCD193
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 22:52:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ct1WW1sQvz3bf8;
	Fri, 24 Oct 2025 09:52:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761202364;
	cv=pass; b=K7kMxzvvdSCugMAeiQrlZPXlSVOiN1PPayyPzdQ3vyEg3GWdy30SnBwUJckxyJeKjnwkTQxXIJD1mD2dXqHMB7kbRZcBqdYdnnZwNq0Q/MsK+Qme8nHMRjhuO1x1nRlUO4aDeidaCOvduiiM/fOjoDbHqjnyjCDbeiQT0xr51bt+iLJSDwofs8dn/vZQAzMzw6KFasM6VAjj0u6TNaqyc0/P+6CAbLDhy88hZ5kStSeNP038efTuvNtsNPFNiCgCHSHm/FCEJ2xmBLV5pjc4c/UY7ji4wylkzzBmEgC4WtCgq+/Tu5nuVBSW1IP/YXC9vv8vxdgt4zX+gjOlOfB9oQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761202364; c=relaxed/relaxed;
	bh=Vv6HknEwscM2+Vb6AMH+eNaCrAMbeL/EfT2kDxsjFkE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qi16uboUQxemnQLVV+2FAXc+EKadiw47146c1QEvs/C2ooBjsdAiI20zhniepElUhLoREudYKHqshWa1M7Mjf4s1vIUjC/Apb01hSMPGmpehTU4nlM8bp3uZJ77V7U4oM5CnU/6sfwqpz8HGUQLPq670F6xZec/534h8QOUC8W+gmUIzWmN9scDvE1RD5XTYM9cSkSlZ9ai1MAMTa2S9onl11dPX0gIGb6bfAW85EOzLfXckztFqwZjBsnklzzNEvwLZG+BzCbrXOwuDVrYK9NffobO+iQiRW0RQKxEdBbNHTU1FnqbhzKzYDTMyCbHJg1btuRbdZvA1nAH9BuptEw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sdxasmGE; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=peter.shen@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sdxasmGE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=peter.shen@amd.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cscDD1db3z3bW7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 17:52:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2Anbyx1aWUygZbpDv+QfBOAhHllk7WHn6lwY/2d5g/EQP/ptxWGdf/yByMOysr7MuyxzDpfCr9wAM06rwu7wfBJifM2GVS73/kNRrw6TBqZes51f1hfU9FErLVjM/MjGdyQQDwkMplBj8Mol6iT1mn9Wr5KdFi+FoqV7hy2x9sQ7iVJj/u/gWg9ehCG5R3ie38VBzYPTxtiJMi1zOzU3Y6FD/O06+nABzy1+NH/rPMWJf1x5Gfbjtj6HYcqIarosNwXs1HciA9JwJkyRIU+5tmhvd8e3EyulsAvS4QsFbdwfPuy/wy+8fU8BaB1/VsgDKWDYpdUPUvCsWmx7G+m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv6HknEwscM2+Vb6AMH+eNaCrAMbeL/EfT2kDxsjFkE=;
 b=UZssstPKL5nRkkHUGJpwQZxT4a6WvdzSAz+GdWa5jqg2xOd7TEMaxT21XyLopLk7mkPYP4EXTafk2s86r4DgoKVRvsHIk/tKMWpr+qQiVsb6RmivvS8OTN+X18JBd7ttmt5R+QB4T+DG89ZQZcDq3PfWNvpJxwn+FDUvh79ggcx/akCizsA1RDmBtrC4JxDZb8DPK+cVt7r6FAoXr3REkvnfUjnFz9TpqZif6n4BHpeHNULjRwXRF8FPJtGqgzyqDADw0yL2FqbWQJwy4e5taUv8boKW1zDihLqpgQq3DvaPYKP9iX6hqbOKOZ/WrjOrF3bDAs1R8tRBEsEmH9ZQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv6HknEwscM2+Vb6AMH+eNaCrAMbeL/EfT2kDxsjFkE=;
 b=sdxasmGESAyUFzkge4ucHM5bzSXlJyrlnjyy5+TnU1dedCiqocW6K0w/FiyoBqoVyCBGlpw/6wuVB3SjkIN1StIzHQh98mHgGdS4oAzgyiJYEhsHmpEQGvpkkrFRFhzIl1zQCwk3GupHfXlYWE4zTM/ZM8rMmgJTsyFCptqmnZ8=
Received: from DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) by
 SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:52:23 +0000
Received: from DS7PR12MB6118.namprd12.prod.outlook.com
 ([fe80::a9fa:4735:e3d3:a0e5]) by DS7PR12MB6118.namprd12.prod.outlook.com
 ([fe80::a9fa:4735:e3d3:a0e5%2]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:52:23 +0000
From: "Shen, Peter" <Peter.Shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
CC: Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Shen, Peter" <Peter.Shen@amd.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook
 Anacapa BMC
Thread-Topic: [PATCH 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
Thread-Index: AQHcQ+gNnRXwq8zRVE6QDcuFRom3yQ==
Date: Thu, 23 Oct 2025 06:52:23 +0000
Message-ID:
 <DS7PR12MB61187E5845B076BF7C7EFE0995F0A@DS7PR12MB6118.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-23T06:52:22.696Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6118:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: 15c04500-64c9-46ad-3a4d-08de1200b817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|8096899003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?63gd8Zo647H5hLHT2dMOD2oKkJra84DuKoBvGGeUrNCuRZW4euedno3KY1?=
 =?iso-8859-1?Q?q34PRJsg0DEqlBkUMp/6jP3lqTXuglgVsgfXTN8t852vtZaG2GqXAW1C1T?=
 =?iso-8859-1?Q?GUJyq31mWQIS0l06UnMTZY2dKC2aZXYzb61wk0W7JjCvYOtYJNz5prXS9T?=
 =?iso-8859-1?Q?+7EqCGBymlnzLsSieC4SiBqvq7AjEvipAqLNj459BUcTW3n5y6Ch5dka7E?=
 =?iso-8859-1?Q?cl/a0/XQEt+HRhd06IRHG/cBqRfKYlJ5hj15gNV5NhaWP2WTTY0gCOkSJZ?=
 =?iso-8859-1?Q?LqNt9/Nds1e9dRFPj3kdyrNfADbYGrbkkGB8TTAfID3z+Oz84WRAMMqtZ/?=
 =?iso-8859-1?Q?SHmlewUHCVaBadRsntV5TZaI8zcF16vlSoF4axSOevNe+onUa7IhorZawH?=
 =?iso-8859-1?Q?8uv5PGaW4LaEVT+0nL5cOK/2VG0OdniU3OxSo3unBExAqgTX9nOl9PfxXO?=
 =?iso-8859-1?Q?lHRK/6WmBY5ckz3xUUXH7VcAr+rvAdAF6fJ58r6CUERJ2XH2v3nkvER8Rr?=
 =?iso-8859-1?Q?XChLzV02ytkpUzc8HuDj9n6PXmpAW1RbKun9gzYsj/CI8tFXj5+OyCTB9s?=
 =?iso-8859-1?Q?KG+zk/zcwEDC6Cx4oDY/arHk7dctKfH++XdKZQcJUy8fYRC5/4VEQ6B7/z?=
 =?iso-8859-1?Q?gt37qO9XBRy5eZiD+k3qUVRtY0mn2duzNPW4MdPQmQajAzk916vqJsxOiy?=
 =?iso-8859-1?Q?62cQlMJ52Cex2NU84VoQadzvwZANRtilLbd2D1LWZwq92RvSNtF1XFtw0k?=
 =?iso-8859-1?Q?jY/WeHBwIgMY+xeHgKfg6qi9YCqu7x7qaRqKn3NjI/UBp/jO6VeO+tmcg4?=
 =?iso-8859-1?Q?0obxuTV+5rJ2U0M6RooWZJbXSSjaAmgKSAOuS9cMzfBmkLVCeXZoX7u21f?=
 =?iso-8859-1?Q?AAugmacNNr9lG8dfApTotUSFDdfsxxe4LuPnocl/0RRegKZyxIZIMCP2uD?=
 =?iso-8859-1?Q?O5rMb7lo0Bakp84S1hxQbWkPiTER9O3RyMARaoygVb7o77r7+nQyJEOTnd?=
 =?iso-8859-1?Q?7WkiLaUIU+cEEXWk7mQvoobSwo5UdhPOBaDfN9KvhF8MimpBgM4JapNe3z?=
 =?iso-8859-1?Q?EHKRQE8PWxt5sMqSIpBjOqf3syz24RyZiG17Kz+ATLzKL2CpmbKqABNQrw?=
 =?iso-8859-1?Q?+C/+6boSqV4At/taeq2GQ07nJ6L6SDDujs5YN7eu0PV3cWzyP05RommLWn?=
 =?iso-8859-1?Q?zgnAs+v8hn1Pm/tzJVehWwdO2Bkm1yxBoOq8QMrgFGDrHmTmgN79wG2N8H?=
 =?iso-8859-1?Q?WyQlh9Hp0E6R5bX7Cc/IhYZDwtfWXwLfS8RoCQ62yaBBmo0STPeP7a53dA?=
 =?iso-8859-1?Q?WIxlNn/QbBhklFFWatK/HgVEGQSxmmz3qA+yTnMY5IV664XeOLmSGQbhfD?=
 =?iso-8859-1?Q?3lkvZNkGCI0gfR93xIAY6Pwfr98onISa5Kc9Y9t2Lx1nWLq/jlAtKzdSVx?=
 =?iso-8859-1?Q?r0SdmOvvxPt8ug0dq9SVGnTPrbERtFJdofDeyZKYvJZaNi1ywUJ8+R0bw5?=
 =?iso-8859-1?Q?37FfmjMALzjTqHIDBIQtj7/NTVnxAD0kYIFVIBlh/FOyy5gsn3aL6FneZp?=
 =?iso-8859-1?Q?p/Sn2nQvSg4ACJbcK8lQHpffsy3W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6118.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0muIqN9Ohjlf7n+NZmSLkBaJFxH5WijV4c6nU/LFDK195oqICH1QaOGoeB?=
 =?iso-8859-1?Q?PdcRQjIV2F2pdn2Dz2WRCE9GEX4chgoch966FvxQqVcnj5ncVS216PrPOf?=
 =?iso-8859-1?Q?sJIlGTmDr7qvQXlGqKhF3C+ExrVWlqtxxZLmc6yCCTHiccxknCDHcmyc+t?=
 =?iso-8859-1?Q?p63ZaNLV8o3j4sx6IbICIngxo9alf2vCuP3/SM1w5yntXutmF9IbvHonzm?=
 =?iso-8859-1?Q?9jnRpah0yO8IaD3ESBVAxrvw6pysMpMZ++wwJVtiIXf8fpRiRSCwtwaWFI?=
 =?iso-8859-1?Q?Y4MAepXIkEqChJRR+UqsbFIAO2vHVamZgVg6TtKGv4fcgqLOxOLpwknNH2?=
 =?iso-8859-1?Q?jwzshukv16oqaFaIItfsa/Hdr/gTkt7Vd6rm5iZcnOxFjrRNUSj1KEdbKs?=
 =?iso-8859-1?Q?xpyjG5z1WMzEw+K4RkwxB9XjGGN1Xakt5/t05HBsvBOh0Z2C7Mt3uKhrB6?=
 =?iso-8859-1?Q?F3AynsPG1YtBxDRFTel8W0g3+yorNG4k/Htc1i3QKyLTOyDtiP1oXRRPPL?=
 =?iso-8859-1?Q?Fa1IlDVqtirc6VilioW9JLafelT2gUqa+8AnWEYry+C1KSKu36EcWpENcW?=
 =?iso-8859-1?Q?WIUjiSDu0VcIKpIawPuSqZc1Jzrs3tZlb/JPaLXEXulQwmD280Ppo2+912?=
 =?iso-8859-1?Q?1lGdlRh8WERA/PpM74d78xovzk388cXCIEpVQdBxNT4Ug3aBEdtSsy3ZbC?=
 =?iso-8859-1?Q?qxvJ7+qj/uVB+QvMetPGSUm94sCGhNYABcb3Fiq3Ktm3meKibj6cgj2NdB?=
 =?iso-8859-1?Q?1NkU7k2jHmuN1tHdLswx0lVskGTnX7pxgHE2jD7fR1gfRBfEh8V52sqYtR?=
 =?iso-8859-1?Q?N3TiBaJLmaNb61mSQV24ZA1gepNfeMVBWyjdDKr8G5wV90Vn/exJ3Mh4vX?=
 =?iso-8859-1?Q?2qVeN8RzMOeH3i6J5HWbyrVPlZ9iY4+sfeUyjPlLLFcHakQ4OH2ubIeQqf?=
 =?iso-8859-1?Q?3Yzml8JsuDnYL8qAa99FwsA/8rP66uumFkpTtVsqke8SXUpRupsJbFGS9H?=
 =?iso-8859-1?Q?8rC0v+95u7F8I9FvYeuGzhYZF6ipsNa17hvkLgybfILklGGzY/LM3zWPh/?=
 =?iso-8859-1?Q?aAMbmJnWQ9AA9oBRd+PCzeCAwk6woacRZOm6rxorzA8Rw0cuXFwIgRd1RI?=
 =?iso-8859-1?Q?CmnQcMeMrq8rtXt6/6Na0VD9wJk+CQoR0VgXjoYMqyROGxrNA3og1FgtfZ?=
 =?iso-8859-1?Q?i4QgZLxS5dA9ILLCAlVwG8pD5ETvpO+s0l0eBg2dJrLxCLBSSBzX4jQVWS?=
 =?iso-8859-1?Q?whTe1mY7m1MjfQN9xNZPx/Hx1YaZI+uKt2yfyG/UZZ+Ck3cABDvidFkBOt?=
 =?iso-8859-1?Q?514uLQqGJq6HyVnBol78UntGlR+lR/7IfGrEw/fZjJ6XJsglukPnqfwczG?=
 =?iso-8859-1?Q?L7Fx5YVzbx+BNRfHZA5+aBtXjGS3Om+JSYfA/QdCRRkaivmVhSZ00UtIQ1?=
 =?iso-8859-1?Q?YE0Ow5BKZqX3iqtDCWdzy2GSYgTjfZLF/jmgd7z4ZSP7Qu6i/GLRkRNwdx?=
 =?iso-8859-1?Q?APNEEYX3lWb/62GZyri7OM42I4R3s2h3f4YFGVdhlzYIOUX1s29MQyRkNB?=
 =?iso-8859-1?Q?PfZbJu/YtjcjfnuOuEj330npjVl/YG+wT8Z8A3BDClPuf+tkUYt2+kEijo?=
 =?iso-8859-1?Q?h/bsf4isGiIbs=3D?=
Content-Type: multipart/alternative;
	boundary="_000_DS7PR12MB61187E5845B076BF7C7EFE0995F0ADS7PR12MB6118namp_"
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6118.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c04500-64c9-46ad-3a4d-08de1200b817
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 06:52:23.0942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ak2x3NTNOxUJ/VsiGP7W15pPZr1pfF3/4M4oeX+js/CrCsEKLfWCHt+F25FoPGzkyVwVQYPlXSfvPHltnbCXOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831

--_000_DS7PR12MB61187E5845B076BF7C7EFE0995F0ADS7PR12MB6118namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

From 3129809145bd283bc52b4e105ea66d217166bb5c Mon Sep 17 00:00:00 2001
From: Peter Shen <peter.shen@amd.com>
Date: Thu, 23 Oct 2025 13:49:52 +0800
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook
 Anacapa BMC

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Doc=
umentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc
--
2.51.0



--_000_DS7PR12MB61187E5845B076BF7C7EFE0995F0ADS7PR12MB6118namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">From 3129809145bd283bc52b4e105ea66d217166b=
b5c Mon Sep 17 00:00:00 2001</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">From: Peter Shen &lt;peter.shen@amd.com&gt=
;</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">Date: Thu, 23 Oct 2025 13:49:52 +0800</spa=
n></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">Subject: [PATCH 1/2] dt-bindings: arm: asp=
eed: Add compatible for Facebook</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp;Anacapa BMC</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;"><br>
</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">This patch adds the compatible string for =
the Facebook Anacapa BMC</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">which uses an Aspeed AST2600 SoC. This is =
required before adding</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">the board's device tree source file.</span=
></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;"><br>
</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">Signed-off-by: Peter Shen &lt;peter.shen@a=
md.com&gt;</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">---</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp;Documentation/devicetree/bindings/ar=
m/aspeed/aspeed.yaml | 1 +</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp;1 file changed, 1 insertion(+)</span=
></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;"><br>
</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">diff --git a/Documentation/devicetree/bind=
ings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/=
aspeed.yaml</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">index aedefca7cf4a..bcb874ebd9d2 100644</s=
pan></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">--- a/Documentation/devicetree/bindings/ar=
m/aspeed/aspeed.yaml</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">+++ b/Documentation/devicetree/bindings/ar=
m/aspeed/aspeed.yaml</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">@@ -80,6 +80,7 @@ properties:</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- aspeed,ast2600-evb</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- aspeed,ast2600-evb-a1</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- asus,x4tf-bmc</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp;- facebook,anacapa-bmc</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- facebook,bletchley-bmc</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- facebook,catalina-bmc</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;- facebook,clemente-bmc</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">--&nbsp;</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;">2.51.0</span></div>
<div style=3D"font-family: &quot;Courier New&quot;, monospace; color: rgb(0=
, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 10pt;"><br>
</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
</body>
</html>

--_000_DS7PR12MB61187E5845B076BF7C7EFE0995F0ADS7PR12MB6118namp_--

