Return-Path: <linux-aspeed+bounces-323-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C697E77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 14:26:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSCz96rcgz3bTM;
	Wed,  8 Jan 2025 01:26:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736259989;
	cv=none; b=PymlLPI1c66d2suPHMbgm9IHA8i071Of2fFtvujbv3VqtZzN93JrnrWOpgW4pd9qQ5PbaQPP4CjcLOoacO1ygeZS7WlNvHlPiqbQ4JVqtQy49lGwPnI0qOujGU+QQImpVWuvtfUMlfbLVmZuM4QCAfi+8Ir+YEkb4LmnppJQZ/O5Av9aw5hTyINS7Ngtt6mQi8gUxw+89/z8KRLFM6pPRoH4cOskYWYEBj8PKJsLmPx6D6zIr/pgfmjJVAJFMw44WZB4MRfXEAz5kBxwOYQtg4b8+/dVksj3cHrO0Oh9fWb0jAYv+IHzFaUjGcGQxORGDshRcHke+6tVuKb2q1/6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736259989; c=relaxed/relaxed;
	bh=8aJq6DyymI3ykrkUx9xwMXuoVHlfLNSCOq31gWtyKFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kziHhsD3BoWegOArJfJUxmzcrhNDic0W1FX4lUBMgpqMFiwXEnyN29xhOlxYH/ZFEUZbwR5HEhV5fu3nOYgRwdk4Irn/G5BJjqcpwF3OfA1z7CTMrIeIPYuupcDEHtO0lLplxDjZ/Kszgs6MNoeDDNagCeM9ll2z5xtWCmqqBB06yATsyxyRGbH/gKk6L6jhwAo/tUyws2jq1vAWbtkWH6qX7hb1OevsfIA0EiA3gc9d4pOB3saPbEQBOGEDHG2OooIAA3DRkHHY5wq4a1Je6GaHYqBSfeQ3pw7yQahJT/19UVQUvm7jAS9lifVmd/OZYIsWo1KEZ/PrSw0uVepKBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LkyKDOF+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LkyKDOF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSCz85tsXz3bTD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 01:26:28 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507E6cSd015943
	for <linux-aspeed@lists.ozlabs.org>; Tue, 7 Jan 2025 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8aJq6D
	yymI3ykrkUx9xwMXuoVHlfLNSCOq31gWtyKFA=; b=LkyKDOF+QHkK190ZU8Mf76
	1MZM8BeA8SbTpFAKBJqxxca/TGESUZbhWf0JgitWETmkMpn4YlAdlE2Pr+D786HE
	n8rOCN146PBanbxKFoL7qIp/UiX+96ZN8fvGx6dC5e44g3/6JFc5JlEJu16Uem1z
	C1jvwlPreHSjqZgV5AyCNZf6A32wXdD/vBdDZjTGYxjpheQgJzigijgH/kyz1PkM
	lX5ofkTW1p+8DmUak9ouJHcdYxHulGo8kLvglRyO9UZWqczAVNswj2Y4OBVAPuBw
	iSo/qiGsHVVVaXpJSGVROYWWJ8dO2pVJEkMl69oS+7YcUWNpU7+sNt0gP/GIRQrQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4415r5037h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jan 2025 14:26:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507CV2Hu003571
	for <linux-aspeed@lists.ozlabs.org>; Tue, 7 Jan 2025 14:26:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat314v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Jan 2025 14:26:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507EQOWA32047748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 7 Jan 2025 14:26:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FED58062
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 14:26:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 462B35805A
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 14:26:24 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <linux-aspeed@lists.ozlabs.org>; Tue,  7 Jan 2025 14:26:24 +0000 (GMT)
Message-ID: <5637e122-760d-4181-87f1-542d78a71e86@linux.ibm.com>
Date: Tue, 7 Jan 2025 08:26:23 -0600
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] ARM: dts: aspeed: system1: Add RGMII support
To: linux-aspeed@lists.ozlabs.org
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
 <20241213145037.3784931-4-ninad@linux.ibm.com>
 <4a8788c1-8424-40f6-a9da-bf135acad29b@lunn.ch>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <4a8788c1-8424-40f6-a9da-bf135acad29b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T42rWI_TK8TibysBwBwHfnkRQbkrOf59
X-Proofpoint-GUID: T42rWI_TK8TibysBwBwHfnkRQbkrOf59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=818
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070118

Hi Andrew,

Thank you for the review. Sorry for the late reply as I was on vacation.

On 12/13/24 16:03, Andrew Lunn wrote:
>> +&mac0 {
>> +	status = "okay";
>> +
>> +	phy-mode = "rgmii-rxid";
> Why is everybody getting RGMII wrong this week?
>
> Do you have an extra long clock line on the PCB for the TX clock?

We are using ASPEED ast2600 chip and their recommendation is to enable 
RX interface delay from the PHY chip for mac0 and mac1.

We tested the network and it is working as expected.

>
>> +	phy-handle = <&ethphy0>;
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
>> +};
>> +
>>   &mac2 {
>>   	status = "okay";
>> +
>> +	phy-mode = "rgmii";
> Do you have extra long clock lines on the PCB for both Rx and Tx
> clock?
>
> I suspect you don't and the RGMII delays are messed up somehow.

This is a recommendation by ASPEED for mac2 and mac3. We tested the 
network and it is working as expected.

Can you please let me know more about your concern?

Regards,

Ninad

>
> 	Andrew
>

