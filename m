Return-Path: <linux-aspeed+bounces-791-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625BC021B1
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Feb 2025 16:15:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YzJK037YFz30Tq;
	Fri, 21 Feb 2025 03:15:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740068148;
	cv=none; b=MJVdgrY+z1a0Rj8NrBFvqbJ3k0jbJC0qZf+yR0crS64tlEQieXH7vqAi7QuelNUShhvby7Qdr4iK91AGmmskCDf7w8BM++97/6sEU1QeeEILyKWBZDtCg97X6u5lYwq0FoICwbwO/yFFw2WW+70zscUdOUE5mKbKJKBFPZpXcuvSL461FvoBGejiW+rf5AIIxWf7RogazMBi43c8dgiwD+VJnrkjYUVUizH8aCk3mlb5uX502+la3AWHE/Ksakk71IUbRX6V5h5CaM2oQYRcrzwlZwdTsh1PBMRPrw3/uk3iDpncdRprQ5xxYOQLz8OIgG6v9m3utkXYBt/PyATT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740068148; c=relaxed/relaxed;
	bh=OIOsvBOcNIo5uWpOxqgJER5g78ZzHEwKiNE80YUjWrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDVjGoH6nG3UT1XRU6yLIllcKHrczy5rddpALqCr6n8dntYfkK5OsB0+YpzAcOy6WP11SMkqY/INP9ZsSSCUevuV2rBcUcKofH3WhCuMjprt/h/w5UWIoXt/LbxFEprREm1RIjuprDZsf4YVLWC4RjGYX0QYz0ewtcBVi9bMQh0GQvujlSNj3mfCJP8NSdoFeBpnWonh5sPF0fAK0LqzBtqnd2FJiwgQ4EnkA6ifAzqxk1IgOhfolDNF8mJqr9iVtqCagAMDcsr3pUx+VRSW7peJrmsqtrr4mYfTW6Ve1tbhl9/Cf+RkAoQGRmRblmatRtGnfd/2Y3bk5GZAuebRmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7VSUjgM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M7VSUjgM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YzJJz1LjZz30TH
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Feb 2025 03:15:46 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KC0Nk2002119;
	Thu, 20 Feb 2025 16:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OIOsvB
	OcNIo5uWpOxqgJER5g78ZzHEwKiNE80YUjWrA=; b=M7VSUjgMEOjg6AikzeFLsK
	g+/1g9FRwYUEJZJkqlSjQ4wIc/20NDDxbdmOopg/zJD01CRwaL9kEaZZ7l9SPC6g
	abguEeh0nR8GDn8ph0UVS1zJWG611++JMGGtlrtjzuDpn33km0JdPCm9VKm+L23I
	XUE2b+S8KzN4DsOcf2+JrVQTurqW1Z3cA3Ca4k7BJEmiWmKRRMYeZ9RcGugIavuW
	8I+ch5fuKZ9EnP0t+y7jIog9AzM/znphAVA5WHcPvippFsUHW3pbegX7SjGoiSmj
	F7izdP+nEQsFaiPZeHs7MJdtLaI57fPMWTlyfpkmUUpNRdDCltBcJ/UbFZzbkDtQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa3ykb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:15:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEU6YL030262;
	Thu, 20 Feb 2025 16:15:38 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xaxt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 16:15:38 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KGFc3K31720052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 16:15:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F5158054;
	Thu, 20 Feb 2025 16:15:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D59FE5805A;
	Thu, 20 Feb 2025 16:15:37 +0000 (GMT)
Received: from [9.61.48.195] (unknown [9.61.48.195])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 16:15:37 +0000 (GMT)
Message-ID: <f9615bfa-9d3a-47df-a5dc-a6a1f3b4940b@linux.ibm.com>
Date: Thu, 20 Feb 2025 10:15:35 -0600
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
Subject: Re: [PATCH 2/3] dt-bindings: hwmon: ucd90320: Add 90160 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org
References: <20250219212735.1365050-1-eajames@linux.ibm.com>
 <20250219212735.1365050-3-eajames@linux.ibm.com>
 <3ed2b213-0219-4ca7-817c-d6adf424612e@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <3ed2b213-0219-4ca7-817c-d6adf424612e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hwx3HPhEc_5YfTe26_0_J_lfKe-0dL_S
X-Proofpoint-GUID: hwx3HPhEc_5YfTe26_0_J_lfKe-0dL_S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=719
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200113


On 2/20/25 08:47, Krzysztof Kozlowski wrote:
> On 19/02/2025 22:27, Eddie James wrote:
>> The 90160 is just like the 90320 but with less GPIs and GPIOs.
> Then isn't it compatible?
>
> Where is your driver change?


Sorry, my commit message should be more clear. The driver already 
supports the ucd90160 and matches the compatible string I added here. 
I'll improve my commit message for v2.


Thanks,

Eddie


>
>
> Best regards,
> Krzysztof
>

